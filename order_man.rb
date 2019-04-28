#encoding: utf-8
#This ruby file will get new orders from pospal and save them to text file
#those text file will be printed to pdf printer and send to printer by powershell scripts

require 'digest/md5'
require 'net/http'
require 'json'
require 'date'
require 'time'
load 'router.rb'
load 'get_orders.rb'

forders = []

#days count backward from today, if days==0 then use tomrrow as shipdate
day_count = ARGV[0].nil? ? 1 : ARGV[0].to_i

if day_count == 0
   the_day = Date.today.next_day
   forders = get_orders_by_shipdate the_day
else
   the_day = Date.today
   day_count.times do 
        forders += get_orders_by_shipdate the_day
        the_day = the_day.prev_day
   end
end

forders.each do |forder|

    order = forder[:order]
    next if order['state'] == 3 #skip canceled order print

    #add header twice
    content  = "                                   每一天,更安心的选择\n"

    # remove '104' from the tail
    content += "##{forder[:number]} #{order['orderDateTime']}\n"

    if order['state']!= 4
      order_state={0=>'初创建',1=>'已同步',2=>'已发货',3=>'已取消',4=>'已完成'}[order['state']]
      pay_method={'Cash'=>'现金','CustomerBalance'=>'余额','Wxpay'=>'微信','Alipay'=>'支付宝'}[order['payMethod']]
      delivery_type={0=>'自营',1=>'自助',2=>'自提',3=>'预约',4=>'三方'}[order['deliveryType']]
      pay_online={0=>'未用',1=>'通过'}[order['payOnLine']]
      opay_completed={0=>'还未',1=>'已经'}[order['isOnlinePaymentCompleted']]
      content += "> 状态#{order_state.nil? ? '未知' : order_state} #{pay_method}支付 #{pay_online}网付 #{opay_completed}完成 #{delivery_type}\n"
    end

    fat_addr = order['contactAddress'].gsub(" ","")
    slim_addr=fat_addr.gsub("\u5E7F\u4E1C\u7701\u5E7F\u5DDE\u5E02","\u5E7F\u5DDE")
    line_mark = decide_route order
    odrmk = order['orderRemark'] ? order['orderRemark'].gsub('配送','') : ''

    content += "#{slim_addr}\n"
    content += "#{order['contactName']}    #{order['contactTel']}\n"
    content += "> #{odrmk}\n"
    content += "#{line_mark} [   ]                                _____ of  1  2  ____\n"

    content += "-----------------------------------------------------------------\n"
    content +=  order['orderNo'] + "-" + order['customerNumber'] + "\n"
    content += "#{order['contactAddress'].strip}\n"
    content += "#{order['contactName']}    #{order['contactTel']}\n"
    content += "> #{odrmk}\n"
    content += "#{line_mark} [   ]                                _____ of  1  2  ____\n"

    if order['state']!= 4 && order['state']!= 3
      content += ">>>>>>>>>警告：非常规状态，需单独处理<<<<<<<<<\n"
    else
      content += "-----------------------------------------------------------------\n"
    end
    content += " 数量     商品名及规格\n"
    items = order['items']
    items.each do |item|
        if item['productQuantity']>1 
            bold = " *"
            bold = "**" if item['productQuantity']>2
            qty = bold + sprintf("%d",item['productQuantity'])
        else
            qty = "  " + sprintf("%d",item['productQuantity'])
        end
        content += "#{qty} [   ] #{item['productName']}\n"
    end
    content += "\n"

    #add footer
    content += "-----------------------------------------------------------------\n"
    content += "若因欠收或品控问题缺货，24小时内原路退款，请留意查收\n"
    content += "售后不满意无障碍退换，请联系小蜜18998382701微信同号\n"
    content += "                 foodtrust.cn 买有机，到丰巢\n"

    order_short_number = order['orderNo'][0..order['orderNo'].length-4]
    customer_number = order['contactTel']
    customer_number += "-c#{order['customerNumber']}" if order['contactTel']!= order['customerNumber']
    #fn_name = ".\\incoming\\" + rday + "-order-" + order_short_number + "-" + order['customerNumber'] + ".txt"

    rday =Date.today.strftime('%Y-%m-%d')
    rtime=Time.now.strftime("%H%M%S")
    fn_name = ".\\incoming\\" + rday + "-order-" + order_short_number + "-" + customer_number + ".txt"
    File.open(fn_name,"w:UTF-8") do |f|
        f.write content
    end
end
