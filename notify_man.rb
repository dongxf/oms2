#This file will notify order delivery message to new order

require 'date'
require 'time'

load 'get_orders.rb'
load 'user_api.rb'
load 'wechat_api.rb'

@rds = Mysql2::Client.new(:host =>ENV['RDS_AGENT'], :username =>"psi_root", :port =>'1401', :password =>ENV['PSI_PASSWORD'], :encoding =>'utf8mb4') if @rds.nil?

def get_delivery_info order

    info = "#{order[:name]}，您的订单已确认。"

    line = order[:line]

    moment = "2019-9-18" #根据订单时间计算
    method = "自营宅配" #第三方快递
    arrive = "当日下午五点前送达" #根据订单地址和时间计算

    case line
    when '[T]'
        info += "我们将按团购商品交付说明为您如期安排配送或产地直发。"
    when '[Z]'
        info += "补拍单将会随主订单一起合并配送，自提单请于#{moment}至丰巢仓库自取。"
    else
        info += "我们将于#{moment}为您安排#{method}，预计到货时间#{arrive}。"
    end

    remark =  "任何问题请联系客服丰巢小蜜，手机微信同号18998382701。\n"
    remark += "【首单提醒】丰巢所有产品禁用化学防腐剂，保质期内如遇任何品质问题，请联系客服做进行无障碍退换。\n" if order[:order_times] == 1
    remark += "FOODTRUST® 丰巢有机\n每一天更安心的选择\n点击详情了解更多。\n"

    method = '宅配订单'

    return {:info => info, :remark => remark, :type => method }
end

def confirm_orders orders
    text = ''
    printf "confirm orders[ "
    orders.each do |order|
        order_id = order[:order_id]
        uid = order[:uid]
        openid = order[:openid]
        cid = order[:customer_id]
        now = Time.now.strftime('%Y-%m-%d %H:%M:%S')
        info = get_delivery_info order
        printf "."
        reason = "#{now} oid##{order_id} 订单确认"
        text += "O##{order_id} C##{cid} #{order[:date_time]}\n"
        text += " #{order[:addr]} #{order[:name]} #{order[:tel]} Y#{sprintf('%.2f',order[:amount])}\n"
        send_confirm_notice openid, info[:info], order_id, info[:type], info[:remark], "https://foodtrust.cn/first-order-qna/"
        comment = order[:comment] + " | #{reason}"
        sqlu = "update ogoods.pospal_orders set notify_history='#{comment}' where order_id = '#{order_id}'"
        resu = @rds.query(sqlu)
    end
    printf " ]done\n"
    return text
end

#待将*改为具体columne以提高效率
#sql = "select * from ogoods.pospal_orders where line != '[X]' and ( notify_history='' or notify_history like 'test%' )"
sql = "select * from ogoods.pospal_orders where line != '[X]' and notify_history like 'test%'"
orders = get_orders_data_by_sql sql
confirm_text = confirm_orders orders
