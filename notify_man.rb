#This file will notify order delivery message to new order

require 'date'
require 'time'

load 'get_orders.rb'
load 'user_api.rb'
load 'wechat_api.rb'

@rds = Mysql2::Client.new(:host =>ENV['RDS_AGENT'], :username =>"psi_root", :port =>'1401', :password =>ENV['PSI_PASSWORD'], :encoding =>'utf8mb4') if @rds.nil?

#This array should be maintenanced manually with aids from gen_holiday()
def is_holiday the_day #using Date type
    ['2020-02-01','2020-02-08','2020-02-15','2020-02-22','2020-02-29','2020-03-07','2020-03-14','2020-03-21','2020-03-28','2020-04-04','2020-04-11','2020-04-18','2020-04-25','2020-05-02','2020-05-09','2020-05-16','2020-05-23','2020-05-30','2020-06-06','2020-06-13','2020-06-20','2020-06-27','2020-07-04','2020-07-11','2020-07-18','2020-07-25','2020-08-01','2020-08-08','2020-08-15','2020-08-22','2020-08-29','2020-09-05','2020-09-12','2020-09-19','2020-09-26','2020-10-03','2020-10-10','2020-10-17','2020-10-24','2020-10-31','2020-11-07','2020-11-14','2020-11-21','2020-11-28','2020-12-05','2020-12-12','2020-12-19','2020-12-26','2021-01-02','2021-01-09','2021-01-16','2021-01-23'].each { |d|
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
    the_day = Date.parse('2020-02-01')
    text =  "["
    360.times do
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

    est = '订单提交后的下一工作日' #'今天'
    eat = '隔日' #'当天'
    order_time = order[:order_time]
    zone_code = order[:zone_code]
    the_day = Date.parse(order_time.strftime('%Y-%m-%d'))
    time_1 = Time.parse(order_time.strftime('%Y-%m-%d 09:00:00'))
    time_2 = Time.parse(order_time.strftime('%Y-%m-%d 15:00:00'))

    ship =  {'ZB'=>'周边小区','ZT'=>'补拍或自提','ZPP'=>'番禺城区','ZPG'=>'广州城区','KD1'=>'珠三角周边','KD2'=>'广东省内','SW'=>'省外到付'}[zone_code] #如果用 {'a':'b'}, 则要用[:a]

    if is_holiday the_day
        est = '订单提交后的下一工作日'
    else
        est = order_time > time_2 ? '订单提交后的下一工作日' : '下单当天'
    end
    eat = '发货次日'

    return {:est => est, :eat => eat, :ship => ship}
end

def get_delivery_info order

    info = "#{order[:name]}：您的订单"

    line = order[:line]
    esat = get_esat order


    case line
    when '[X]'
        info += "已整单取消，感谢信任！售后请联系商店客服的企业微信"
        ship = '已取消订单'
    when '[T]'
        info += "已收到，我们将按该团的【交付时间】，为您安排配送或产地直发。"
        info += "感谢信任！售后请联系商店客服的企业微信"
        ship = '团购订单'
    when '[Z]'
        info += "已收到，补拍订单将与主订单一起合并配送，自提单请于【#{esat[:est]}】至丰巢仓库自取。"
        info += "感谢信任！售后请联系商店客服的企业微信"
        ship = '补拍或自提订单'
    else
        info += "已收到，我们将于【#{esat[:est]}】为您进行发货，预计【#{esat[:eat]}】送达，感谢信任！售后请联系商店客服的企业微信"
        ship = esat[:ship]
    end

    if order[:order_times] == 1
        remark = "【首单提醒】保质期内品质问题无障碍退换，点击详情查看！！\nFOODTRUST®\n让健康和友善触手可及"
    else
        #remark = "常见订单问答请点查看详情\nFOODTRUST® 让健康和友善触手可及"
        remark = "【重要提示】点击详情查看疫情期间服务调整公告！以及新客服通道!\nFOODTRUST®\n让健康和友善触手可及"
    end

    return {:info => info, :remark => remark, :ship=> ship }
    p info
    p remark
    p ship
end

def confirm_orders orders
    text = ''
    printf "confirm orders[ "
    orders.each do |order|

        #send wechat template message
        order_id = order[:order_id]
        uid = order[:uid]
        openid = order[:openid]
        cid = order[:customer_id]
        now = Time.now.strftime('%Y-%m-%d %H:%M:%S')
        info = get_delivery_info order
        info_body = info[:info]
        info_body = "【更新】" + info[:info] if order[:notify_history] == 'resend'
        printf "."
        notification = "#{now} oid##{order_id} 订单配送提示"
        text += "O##{order_id} #{order[:line]} #{order[:zone_code]} #{order[:order_time]} #{order[:addr]}\n"
        text += " #{info[:info]}\n"
        send_confirm_notice openid, info_body, "#{order[:order_id]} #{sprintf('%.2f',order[:amount])}\n#{order[:addr]}\n#{order[:tel]}", info[:ship], info[:remark], "https://foodtrust.cn/sla-3-3-1/", order[:order_times]

        #send work wechat bot message
        content = "老板们，来单咯~\n"
        list = []
        if order[:order_times]==1
            content = "小蜜，快来接新客哦\n" 
            list = ["foodcherry"] 
        end
        content += ">#{order[:order_id]} RMB#{sprintf('%.2f',order[:amount])}\n
        >#{order[:addr]}\n
        >#{order[:tel]} #{order[:name]}\n"
        send_bot_message content,list

        #update notification history
        comment = order[:notify_history] + " | #{notification}"
        sqlu = "update ogoods.pospal_orders set notify_history='#{comment}' where order_id = '#{order_id}'"
        resu = @rds.query(sqlu)
    end
    printf " ]done\n"
    return text
end

#待将*改为具体columne以提高效率
sql = "select * from ogoods.pospal_orders where line != '[X]' and ( notify_history='' or notify_history like 'test%' or notify_history = 'resend' )"
orders = get_orders_data_by_sql sql
confirm_text = confirm_orders orders
puts confirm_text
