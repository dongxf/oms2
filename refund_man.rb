#This file will refund ship fee for qualified orders

require 'date'
require 'time'

load 'get_orders.rb'
load 'user_api.rb'
load 'wechat_api.rb'

@rds = Mysql2::Client.new(:host =>ENV['RDS_AGENT'], :username =>"psi_root", :port =>'1401', :password =>ENV['PSI_PASSWORD'], :encoding =>'utf8mb4') if @rds.nil?

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

def refund_orders orders
    text = ''
    printf "refund orders[ "
    orders.each do |order|
        order_id = order[:order_id]
        uid = order[:uid]
        openid = order[:openid]
        cid = order[:customer_id]
        now = Time.now.strftime('%Y-%m-%d %H:%M:%S')
        refund_balance = get_balance_to_refund order #符合退款条件的省内订单周边小区或省外退回10元运费 #符合退款条件的团购订单
        if refund_balance > 0.0
            #puts "refund balance Y#{sprintf('%.2f',refund_balance)} to #{order[:name]} uid##{uid} oid##{order[:order_id]}..."
            req = { 'customerUid' => uid, 'balanceIncrement' => refund_balance, 'pointIncrement' => 0, 'dataChangeTime' => now }
            res = pospal_api :updateBiPi, req
            reason = ''
            if res['status'] == 'success'
                printf "."
                reason = "#{now} 退费成功: oid##{order_id} 团购订单或特定小区运费返还 #{sprintf('%.2f',refund_balance)}"
                text += "O##{order_id} C##{cid} #{order[:date_time]} +#{sprintf('%.2f',refund_balance)}\n"
                text += " #{order[:addr]} #{order[:name]} #{order[:tel]} Y#{sprintf('%.2f',order[:amount])}\n"
                send_specific_balance_notice openid, "+#{sprintf('%.2f',refund_balance)}", reason, "https://shop.foodtrust.cn/m/accountv4", "#{order[:name]}，您的账户余额有变动，详情如下"
            else
                printf "x"
                reason = "#{now} 退费失败: oid##{order_id} 团购订单或特定小区运费返还 #{sprintf('%.2f',refund_balance)}"
                message = "#{now} 因技术故障，订单#{order_id} 运费返还到余额未成功，系统将于下一次的18:00为您再次处理，如需提前处理请联系丰巢小蜜，不便之处请多包涵"
                text += "O##{order_id} C##{cid} #{order[:date_time]} <<< 返回失败\n"
                text += " #{order[:addr]} #{order[:name]} #{order[:tel]} Y#{sprintf('%.2f',order[:amount])}\n"
                send_specific_balance_notice openid, "+0分", message, "https://shop.foodtrust.cn/m/accountv4", "#{order[:name]}，您的账户余额有变动，详情如下"
            end
            comment = order[:comment] + " | #{reason}"
            sqlu = "update ogoods.pospal_orders set comment='#{comment}', ship_refunded=#{refund_balance}  where order_id = '#{order_id}'"
            resu = @rds.query(sqlu)
        end
    end
    printf " ]done\n"
    return text
end

def award_orders orders
    text = ''
    printf "award orders[ "
    orders.each do |order|
        order_id = order[:order_id]
        uid = order[:uid]
        openid = order[:openid]
        cid = order[:customer_id]
        now = Time.now.strftime('%Y-%m-%d %H:%M:%S')
        award_points = get_points_to_award order #省外奖励积分
        if award_points > 0
            #puts "award points #{sprintf('%.2f',award_points)} to #{order[:name]} uid##{uid} oid##{order[:order_id]}..."
            req = { 'customerUid' => uid, 'balanceIncrement' => 0.0, 'pointIncrement' => award_points, 'dataChangeTime' => now }
            res = pospal_api :updateBiPi, req
            reason = ''
            if res['status'] == 'success'
                printf "."
                reason = "#{now} 补贴成功: oid##{order_id} 省外订单超过298奖励积分 #{sprintf('%.2f',award_points)}"
                text += "  #{order[:addr]}\n  #{order[:name]} #{order[:tel]}\n"
                send_specific_points_notice openid, "#{award_points}分", reason, "https://shop.foodtrust.cn/m/accountv4", "#{order[:name]}，您的会员积分有变动，详情如下", res['data']['pointAfterUpdate'].to_s
                text += "O##{order_id} C##{cid} #{order[:date_time]} p#{sprintf('%.2f',award_points)}\n"
                text += " #{order[:addr]} #{order[:name]} #{order[:tel]} Y#{sprintf('%.2f',order[:amount])}\n"
            else
                printf "x"
                reason = "#{now} 补贴失败: oid##{order_id} 省外订单超过298补贴积分 #{sprintf('%.2f',award_points)}"
                message = "因技术故障，订单#{order_id} 省外运费积分补贴未成功，系统将于下一次的18:00为您再次处理，如需提前处理请联系丰巢小蜜，不便之处请多包涵"
                send_specific_points_notice openid, "+0.00", message, "https://shop.foodtrust.cn/m/accountv4", "#{order[:name]}，您的会员积分有变动，详情如下"
            send_specific_points_notice openid, point, reason, 'https://shop.foodtrust.cn/m/accountv4#/invite', "您的积分余额有变动，详情如下", res['data']['pointAfterUpdate'].to_s
                text += "O##{order_id} C##{cid} #{order[:date_time]} <<< 补贴失败\n"
                text += " #{order[:addr]} #{order[:name]} #{order[:tel]} Y#{sprintf('%.2f',order[:amount])}\n"
            end
            comment = order[:comment] + " | #{reason}"
            sqlu = "update ogoods.pospal_orders set comment='#{comment}', point_awarded=#{sprintf('%.2f',award_points)}  where order_id = '#{order_id}'"
            resu = @rds.query(sqlu)
        end
    end
    printf " ]done\n"
    return text
end

#待将*改为具体columne以提高效率
sql = "select * from ogoods.pospal_orders where line != '[X]' and order_time >= '2019-06-01' and ( shipping_fee >= 10.00 and ship_refunded = 0.0 and ( ( zone_code = 'ZB' and amount >= 98.0 ) or line = '[T]' or (  zone_code = 'SW' ) ) )"
#sql = sql + " and customer_id = '136000600440' " #This is for test only
orders = get_orders_data_by_sql sql
refund_text = refund_orders orders

sql = "select * from ogoods.pospal_orders where line != '[X]' and order_time >= '2019-06-01' and point_awarded = 0.0 and zone_code = 'SW' and amount >= 198"
#sql = sql + " and customer_id = '136000600440' " #This is for test only
orders = get_orders_data_by_sql sql
award_text = award_orders orders

if refund_text.length > 0 || award_text.length > 0
    text = ">>> 运费返回记录  #{Time.now.to_s} <<<\n"
    text += "\n--退运费\n"
    text += refund_text
    text += "\n--奖励积分\n"
    text += award_text
    #text += "\n--折扣补漏\n"
    #text += rebate_text
    rtime = Time.now.strftime('%Y-%m-%d-%H%M%S')
    fn = ".\\incoming\\refund-order-" + rtime + ".txt"
    File.open(fn,"w:UTF-8") { |f| f.write text }
end
