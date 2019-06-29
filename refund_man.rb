#This file will refund ship fee for qualified orders

require 'date'
require 'time'

load 'get_orders.rb'
load 'user_api.rb'
load 'wechat_api.rb'

def should_refund order

        return false if order[:online_paid]!= 1
        refunded_fee = 0
        refunded_fee = order[:ship_refunded] if order[:ship_refunded] #解决nil的问题
        return false if order[:shipping_fee] <= 0 #没有收过运费
        return false if refunded_fee > 0 #已经退回过
        return true if order[:zone_code] =='ZB' && order[:amount] >=98 #shipping_fee is included in order amount
        return true if order[:zone_code] =='SW' #省外都是到付，只要收了就应该退回去
        return true if order[:line] == '[T]' #对团购订单退款，未拼团成功的订单也在这个表上
        return false
end

def should_award order

    return false if order[:online_paid]!= 1
    return false if order[:zone_code] != 'SW'
    return false if order[:amount] < 198
    point_awarded = 0
    point_awarded = order[:point_awarded] if order[:point_awarded] #解决nil的问题
    return false if point_awarded > 0
    return true
end

def send_balance_notice openids
    notice = {
        touser: 'owHN1t0ETyOD1p_J324Gcb9twHuk',
        template_id:  'JJq04n18SSmcNItaCwcLDmNqFJoGCIk5nvOWPm3KvJg',
        url:  'https://shop.foodtrust.cn/m/accountv4',  
        data:  {
            first:  { value:  "您的账户余额有变动，详情如下", color:  '#173177' },
            keyword1:  { value:   "会员账户余额", color:  '#173177' },
            keyword2:  { value:  '系统每日批处理', color:  '#ff0000' },
            keyword3:  { value:  "团购订单或特定区域运费返回\n运费退回规则：\n *所有已提交的团购订单（无论是否拼成）\n *特定小区大于88元的日常订单\n *广东省外快递改为到付(满298另有积分奖励)", color:  '#173177' },
            keyword4:  { value:  '+10.00', color:  '#0000ff' },
            keyword5:  { value:  '点击详情查看最新余额', color:  '#0000ff' },
            remark:  { value: "FOODTRUST® 丰巢有机\n每一天更安心的选择", color:  '#88b04b' },
        }
    }
    wat = wechat_access_token
    openids.each do |openid|
        notice.store(:touser,openid) #注意，如果是'touser' 就不工作了
        wechat_api :sendTemplateMessage, wat, notice
    end
end

def update_zc order
    zc = get_zone_code JSON.parse(order[:raw_data])
    order_id = order[:order_id]
    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])
    sqlu = "update ogoods.pospal_orders set zone_code='#{zc}' where order_id = #{order_id}"
    resu = rds.query(sqlu)
end

oorders = []

#days count backward from today, defualt is 1, if count==0 then use tomrrow as shipdate
day_count = ARGV[0].nil? ? 1 : ARGV[0].to_i

if day_count == 0
   the_day = Date.today.next_day
   oorders = get_ogoods_orders_by_shipdate the_day
else
   the_day = Date.today
   day_count.times do 
        oorders += get_ogoods_orders_by_shipdate the_day
        the_day = the_day.prev_day
   end
end

rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])

flist="" #运费返回表
plist="" #积分奖励表
count = 0

oorders.each do |order|

    order_id = order[:order_id]
    uid = get_uid_by_number order[:customer_id]
    openid = get_openid_by_number order[:customer_id]
    now = Time.now.strftime('%Y-%m-%d-%H:%M:%S')

    #符合退款条件的省内订单周边小区或省外退回10元运费
    #符合退款条件的团购订单
    if should_refund order
           puts "refund shipping_fee to cid##{order[:customer_id]} for oid##{order_id} at addr: #{order[:addr]}"
           fee = order[:shipping_fee]

           req = { 'customerUid' => uid, 'balanceIncrement' => 10.00, 'pointIncrement' => 0, 'dataChangeTime' => now }
           pospal_api :updateBiPi, req
           comment = order[:comment] + " | #{sprintf('%.2f',fee)} shipfee refunded at #{now}"
           sqlu = "update ogoods.pospal_orders set comment='#{comment}', ship_refunded=10  where order_id = '#{order_id}'"
           resu = rds.query(sqlu)
           count += 1
           flist += "#{order[:order_time]}    Y#{sprintf('%.2f',order[:amount])}\n"
           flist += "  C##{order[:customer_id]} O##{order_id}\n"
           flist += "  #{order[:addr]}\n  #{order[:name]} #{order[:tel]}\n"
           send_balance_notice [ openid ]
    end

    #省外奖励积分
    if should_award order
           puts "award points to cid##{order[:customer_id]} for oid# #{order_id} at addr: #{order[:addr]}"

           point = 1000
           point = 2000 if order[:amount] >= 298
           req = { 'customerUid' => uid, 'balanceIncrement' => 0, 'pointIncrement' => point, 'dataChangeTime' => Time.now.strftime('%Y-%m-%d %H:%M:%S') }
           pospal_api :updateBiPi, req
           comment = order[:comment] + " | #{point} points awarded at #{now}"
           sqlu = "update ogoods.pospal_orders set comment='#{comment}', point_awarded=#{point}  where order_id = '#{order_id}'"
           resu = rds.query(sqlu)
           count += 1
           plist += "#{order[:order_time]}    P#{point}\n"
           plist += "  C##{order[:customer_id]} O##{order_id}\n"
           plist += "  #{order[:addr]}\n  #{order[:name]} #{order[:tel]}\n"
    end

end

if count > 0
        text = ">>> 运费返回记录  #{Time.now.to_s} <<<\n"
        text += "\n--退运费\n"
        text += flist
        text += "\n--奖励积分\n"
        text += plist
        rtime = Time.now.strftime('%Y-%m-%d-%H%M%S')
        fn = ".\\incoming\\refund-order-" + rtime + ".txt"
        File.open(fn,"w:UTF-8") { |f| f.write text }
end
