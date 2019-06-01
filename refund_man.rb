#This file will refund ship fee for qualified orders

require 'date'
require 'time'

load 'get_orders.rb'
load 'user_api.rb'

def should_refund order

        return false if order[:shipping_fee] <= 0 #没有收过运费
        return false if order[:ship_refunded] > 0 #已经退回过
        refunded_fee = 0
        refunded_fee = order[:ship_refunded] if order[:ship_refunded] #解决nil的问题
        return false if refunded_fee > 0
        return true if order[:zone_code] =='ZB' && order[:amount] >=98 #shipping_fee is included in order amount
        return true if order[:zone_code] =='SW' #省外都是到付，只要收了就应该退回去
        return false
end

def should_award order

    return false if order[:zone_code] != 'SW'
    return false if order[:amount] < 198
    point_awarded = 0
    point_awarded = order[:point_awarded] if order[:point_awarded] #解决nil的问题
    return false if point_awarded > 0
    return true
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
day_count = 2 if Date.today.wday==0 && ARGV[0].nil? #if Sunday

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

oorders.each do |order|

    order_id = order[:order_id]
    uid = get_uid_by_number order[:customer_id]

    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])

    #符合退款条件的省内订单周边小区或省外退回10元运费
    if should_refund order
           now = Time.now.strftime('%Y-%m-%d %H:%M:%S')
           puts "refund shipping_fee to cid##{order[:customer_id]} for oid##{order_id} at addr: #{order[:addr]}"
           fee = order[:shipping_fee]

           req = { 
                    'customerUid' => uid,
                    'balanceIncrement' => fee,
                    'pointIncrement' => 0,
                    'dataChangeTime' => now
            }
            pospal_api :updateBiPi, req
            comment = order[:comment] + " | #{sprintf('%.2f',fee)} shipfee refunded at #{now}"
            sqlu = "update ogoods.pospal_orders set comment='#{comment}', ship_refunded=10  where order_id = '#{order_id}'"
            resu = rds.query(sqlu)
    end

    if should_award order
           #省外奖励积分
           now = Time.now.strftime('%Y-%m-%d %H:%M:%S')
           puts "award points to cid##{order[:customer_id]} for oid# #{order_id} at addr: #{order[:addr]}"

           point = 1000
           point = 2000 if order[:amount] >= 298
           req = { 
                    'customerUid' => uid,
                    'balanceIncrement' => 0,
                    'pointIncrement' => point,
                    'dataChangeTime' => Time.now.strftime('%Y-%m-%d %H:%M:%S')
           }
           pospal_api :updateBiPi, req
           comment = order[:comment] + " | #{point} points awarded at #{now}"
           sqlu = "update ogoods.pospal_orders set comment='#{comment}', point_awarded=#{point}  where order_id = '#{order_id}'"
           resu = rds.query(sqlu)
    end

end
