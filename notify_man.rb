#This file will notify order delivery message to new order

require 'date'
require 'time'

load 'get_orders.rb'
load 'user_api.rb'
load 'wechat_api.rb'

@rds = Mysql2::Client.new(:host =>ENV['RDS_AGENT'], :username =>"psi_root", :port =>'1401', :password =>ENV['PSI_PASSWORD'], :encoding =>'utf8mb4') if @rds.nil?

#get estimated ship time and estimated arrive time
def get_esat order
     est = '下一工作日' #'今天'
     eat = '隔日' #'当天'
     ship = '自营宅配' #'第三方快递' '补拍或自提'
     return {:est => est, :eat => eat, :ship => ship}
end

def get_delivery_info order

    info = "您的订单"

    line = order[:line]
    zone_code = order[:zone_code]
    esat = get_esat order


    case line
    when '[X]'
        info += "已整单取消，感谢信任与支持！任何问题请联系客服丰巢小蜜，手机微信同号18998382701。"
    when '[T]'
        info += "已收到，我们将按该团购说明的【交付时间】，为您安排配送或产地直发至以下地址：\n#{order[:addr]}\n"
        info += "感谢信任与支持！如需调整或有任何问题请联系客服丰巢小蜜，手机微信同号18998382701。"
    when '[Z]'
        info += "已收到，我们将随主订单一起合并配送，自提单请于【#{esat[:est]}后】至丰巢仓库自取。\n"
        info += "感谢信任与支持！如需调整或有任何问题请联系客服丰巢小蜜，手机微信同号18998382701。"
    else
        info += "已收到，我们将于【#{esat[:est]}】为您配送至以下地址：\n#{order[:addr]}\n"
        info += "预计【#{esat[:eat]}】可送达，感谢信任与支持！如需调整或有任何问题请联系客服丰巢小蜜，手机微信同号18998382701。"
    end

    remark = ""
    remark += "【首单提醒】丰巢所有产品禁用化学防腐剂，保质期内如遇任何品质问题，请联系客服做进行无障碍退换。\n" if order[:order_times] == 1
    remark += "FOODTRUST® 丰巢有机\n每一天，更安心的选择\n点击详情了解订单常见问答。\n"

    return {:info => info, :remark => remark, :ship=> esat[:ship] }
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
        notification = "#{now} oid##{order_id} 订单配送提示"
        text += "O##{order_id} C##{cid} #{order[:date_time]} #{order[:name]}\n"
        text += " #{info[:info]}\n"
        send_confirm_notice openid, info[:info], order_id, info[:ship], info[:remark], "https://foodtrust.cn/first-order-qna/"
        comment = order[:notify_history] + " | #{notification}"
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
puts confirm_text
