#This file will notify order delivery message to new order

require 'date'
require 'time'

load 'get_orders.rb'
load 'user_api.rb'
load 'wechat_api.rb'

@rds = Mysql2::Client.new(:host =>ENV['RDS_AGENT'], :username =>"psi_root", :port =>'1401', :password =>ENV['PSI_PASSWORD'], :encoding =>'utf8mb4') if @rds.nil?

#This array should be maintenanced manually with aids from gen_holiday()
def is_holiday the_day #using Date type
    ['2019-09-14','2019-09-21','2019-10-01','2019-10-02','2019-10-03','2019-10-04','2019-10-05','2019-10-12','2019-10-19','2019-10-26','2019-11-02','2019-11-09','2019-11-16','2019-11-23','2019-11-30','2019-12-07','2019-12-14','2019-12-21','2019-12-28','2020-01-04'].each { |d|
        return true if the_day == Date.parse(d) }
    return false
end

#order_time = Time.new
#time_1 = Time.parse(order_time.strftime('%Y-%m-%d 09:00:00'))
#time_2 = Time.parse(order_time.strftime('%Y-%m-%d 14:00:00'))
#puts time_1
#puts time_2
#puts order_time > time_1 && order_time < time_2

def gen_holidays
    the_day = Date.parse('2019-09-10')
    text =  "["
    120.times do
        if the_day.wday == 6
            text += "'#{the_day}',"
        end
        the_day = the_day.next_day
    end
    text += "]"
end
#use to generate holiday data draft
#puts gen_holidays

#get estimated ship time and estimated arrive time
def get_esat order

    est = '下一工作日' #'今天'
    eat = '隔日' #'当天'
    order_time = order[:order_time]
    zone_code = order[:zone_code]
    the_day = Date.parse(order_time.strftime('%Y-%m-%d'))
    time_1 = Time.parse(order_time.strftime('%Y-%m-%d 09:10:00'))
    time_2 = Time.parse(order_time.strftime('%Y-%m-%d 14:00:00'))
    ship = {'ZB':'周边小区宅配','ZT':'补拍或自提','ZPP':'番禺城区宅配','ZPG':'广州城区宅配','KD1':'广深东莞快递','KD2':'广东省内快递','SW':'广东省外到付'}[zone_code]

    case zone_code
    when 'ZB','ZT'
        if is_holiday the_day
            est = '下一工作日'
        else
            est = order_time > time_2 ? '下一工作日' : '今天'
        end
        eat = '当天'
    when 'ZPP', 'ZPG' 
        if is_holiday the_day
            est = '下一工作日'
        else
            est = order_time > time_1 ? '下一工作日' : '今天'
        end
        eat = '当天'
    when 'KD1' 
        if is_holiday the_day
            est = '下一工作日'
            eat = '当天'
        else
            if order_time <= time_1
                est = '今天'
                eat = '当天'
            else
                if order_time <= time_2
                    est = '今天'
                    eat = '隔日'
                else
                    est = '下一工作日'
                    eat = '当天'
                end
            end
        end
    when 'KD2','SW'
        if is_holiday the_day
            est = '下一工作日'
            eat = '隔日'
        else
            est = order_time > time_2 ? '下一工作日' : '今天'
            eat = '隔日'
        end
    else 
        ship = '其它配送订单'
        est = '待确定'
        eat = '待确定'
    end

    return {:est => est, :eat => eat, :ship => ship}
end

def get_delivery_info order

    info = "您的订单"

    line = order[:line]
    esat = get_esat order


    case line
    when '[X]'
        info += "已整单取消，感谢信任与支持！如有任何问题请联系客服丰巢小蜜，手机微信同号18998382701。"
        ship = '已取消订单'
    when '[T]'
        info += "已收到，我们将按该团的【交付时间】，为您安排配送或产地直发。"
        info += "感谢信任与支持！如需调整安排或有任何问题请联系客服丰巢小蜜，手机微信同号18998382701。"
        ship = '团购订单'
    when '[Z]'
        info += "已收到，补拍订单将与主订单一起合并配送，自提单请于【#{esat[:est]}】至丰巢仓库自取。"
        info += "感谢信任与支持！如需调整安排或有任何问题请联系客服丰巢小蜜，手机微信同号18998382701。"
        ship = '补拍或自提订单'
    else
        info += "已收到，我们将于【#{esat[:est]}】为您进行配送，预计【#{esat[:eat]}】送达，感谢信任与支持！如需调整安排或任何问题请联系客服丰巢小蜜，手机微信同号18998382701。"
        ship = esat[:ship]
    end

    remark = ""
    remark += "【首单提醒】丰巢所有产品禁用化学防腐剂，保质期内如遇任何品质问题，请联系客服无障碍退换。\n" if order[:order_times] == 1
    remark += "FOODTRUST® 丰巢有机\n每一天，更安心的选择\n点击详情查看订单常见问答。\n"

    return {:info => info, :remark => remark, :ship=> ship }
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
        text += "O##{order_id} #{order[:line]} #{order[:zone_code]} #{order[:order_time]} #{order[:addr]}\n"
        text += " #{info[:info]}\n"
        send_confirm_notice openid, info[:info], "#{order[:order_time]}\n#{order_id}\n#{order[:addr]}", info[:ship], info[:remark], "https://foodtrust.cn/first-order-qna/"
        comment = order[:notify_history] + " | #{notification}"
        sqlu = "update ogoods.pospal_orders set notify_history='#{comment}' where order_id = '#{order_id}'"
        resu = @rds.query(sqlu)
    end
    printf " ]done\n"
    return text
end

#待将*改为具体columne以提高效率
sql = "select * from ogoods.pospal_orders where line != '[X]' and ( notify_history='' or notify_history like 'test%' )"
orders = get_orders_data_by_sql sql
confirm_text = confirm_orders orders
puts confirm_text
