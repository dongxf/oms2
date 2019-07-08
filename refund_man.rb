#This file will refund ship fee for qualified orders

require 'date'
require 'time'

load 'get_orders.rb'
load 'user_api.rb'
load 'wechat_api.rb'

def get_balance_to_refund order
        return 0 if order[:online_paid]!= 1
        refunded_fee = 0
        refunded_fee = order[:ship_refunded] if order[:ship_refunded] #解决nil的问题
        return 0 if order[:shipping_fee] <= 0 #没有收过运费
        return 0 if refunded_fee > 0 #已经退回过
        return order[:shipping_fee] if order[:zone_code] =='ZB' && order[:amount] >=98 #shipping_fee is included in order amount
        return order[:shipping_fee] if order[:zone_code] =='SW' #省外都是到付，只要收了就应该退回去
        return order[:shipping_fee] if order[:line] == '[T]' #对团购订单退款，未拼团成功的订单也在这个表上
        return 0
end

def get_points_to_award order
    return 0 if order[:online_paid]!= 1
    return 0 if order[:zone_code] != 'SW'
    return 0 if order[:amount] < 198
    points_awarded = 0
    points_awarded = order[:point_awarded] if order[:point_awarded] #解决nil的问题
    return 0 if points_awarded > 0
    points = 1000 #满198赠送10元
    points = 2000 if order[:amount] >= 298 #满298赠送20元
    return points
end

def get_points_to_rebate order
    return 0
end

def update_zc order
    zc = get_zone_code JSON.parse(order[:raw_data])
    order_id = order[:order_id]
    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])
    sqlu = "update ogoods.pospal_orders set zone_code='#{zc}' where order_id = #{order_id}"
    resu = rds.query(sqlu)
end

p 'usage: ruby refund_man.rb [start_date backward_total_days]'
p 'eg: ruby refund_man.rb 2019-07-01 3'
day = Date.today
count = 2
day = Date.parse(ARGV[0]) if ARGV[0]
count = ARGV[1].to_i if ARGV[1]

oorders = []

count.times do
    stime = day.strftime('%Y-%m-%d') + " 00:00:00"
    etime = day.strftime('%Y-%m-%d') + " 23:59:59"
    oorders = get_ogoods_orders_within stime, etime
    day = day.prev_day
end

rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])

flist="" #运费返回表
plist="" #积分奖励表
rlist="" #折扣返回
count = 0

oorders.each do |order|

    order_id = order[:order_id]
    uid = order[:uid]
    openid = order[:openid]
    now = Time.now.strftime('%Y-%m-%d-%H:%M:%S')
    balance_inc = 0.0
    point_inc = 0.0

    #符合退款条件的省内订单周边小区或省外退回10元运费
    #符合退款条件的团购订单
    refund_balance = get_balance_to_refund order
    if refund_balance > 0
           puts "refund shipping_fee to cid##{order[:customer_id]} for oid##{order_id} at addr: #{order[:addr]}"

           balance_inc += refund_balance

           reason = "订单#{order_id} 团购订单或特定小区运费返回 #{sprintf('%.2f',refund_balance)} shipfee refunded at #{now}"
           comment = order[:comment] + " | #{reason}"
           sqlu = "update ogoods.pospal_orders set comment='#{comment}', ship_refunded=#{refund_balance}  where order_id = '#{order_id}'"
           resu = rds.query(sqlu)
           count += 1
           flist += "#{order[:order_time]}    Y#{sprintf('%.2f',order[:amount])}-#{sprintf('%.2f',refund_balance)} #{order[:line]}\n"
           flist += "  C##{order[:customer_id]} O##{order_id}\n"
           flist += "  #{order[:addr]}\n  #{order[:name]} #{order[:tel]}\n"
           send_specific_balance_notice openid, "+#{sprintf('%.2f',refund_balance)}", reason, "https://shop.foodtrust.cn/m/accountv4"
    end

    #省外奖励积分
    award_points = get_points_to_award order
    if award_points > 0
           puts "award points to cid##{order[:customer_id]} for oid# #{order_id} at addr: #{order[:addr]}"

           point_inc += award_point

           reason = "订单#{order_id} 省外运费补贴 #{award_point}积分 points awarded at #{now}"
           comment = order[:comment] + " | #{reason}"
           sqlu = "update ogoods.pospal_orders set comment='#{comment}', point_awarded=#{sprintf('%.2f',award_point)}  where order_id = '#{order_id}'"
           resu = rds.query(sqlu)
           count += 1
           plist += "#{order[:order_time]}    P#{award_points} #{order[:line]}\n"
           plist += "  C##{order[:customer_id]} O##{order_id}\n"
           plist += "  #{order[:addr]}\n  #{order[:name]} #{order[:tel]}\n"
           send_specific_points_notice openid, "#{award_points}分", reason, "https://shop.foodtrust.cn/m/accountv4"
    end

    # 折扣计算遗漏的部分
    rebate_points = get_points_to_rebate order
    if rebate_points > 0
        puts "rebate points to cid##{order[:customer_id]} for oid# #{order_id} at addr: #{order[:addr]}"

        point_inc += rebate_points

        comment = order[:comment] + " | #{rebate_points} points rebated at #{now}"
        sqlu = "update ogoods.pospal_orders set comment='#{comment}', point_rebated=#{sprintf('%2.f',rebate_points)}  where order_id = '#{order_id}'"
        resu = rds.query(sqlu)
        count += 1
        rlist += "#{order[:order_time]}    R#{rebate_points} #{order[:line]}\n"
        rlist += "  C##{order[:customer_id]} O##{order_id}\n"
        rlist += "  #{order[:addr]}\n  #{order[:name]} #{order[:tel]}\n"
    end

    if refund_balance > 0 || award_points > 0 || rebate_points > 0
        puts "update customer uid #{uid} with balanceIncrement=#{sprintf('%.2f',balance_inc)}, pointIncrement=#{sprintf('%.2f',point_inc)}..."
        req = { 'customerUid' => uid, 'balanceIncrement' => balance_inc, 'pointIncrement' => point_inc, 'dataChangeTime' => now }
        res = pospal_api :updateBiPi, req
        ap res
    end
end

if count > 0
        text = ">>> 运费返回记录  #{Time.now.to_s} <<<\n"
        text += "\n--退运费\n"
        text += flist
        text += "\n--奖励积分\n"
        text += plist
        text += "\n--折扣补漏\n"
        text += rlist
        rtime = Time.now.strftime('%Y-%m-%d-%H%M%S')
        fn = ".\\incoming\\refund-order-" + rtime + ".txt"
        File.open(fn,"w:UTF-8") { |f| f.write text }
end
