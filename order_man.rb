#encoding: utf-8
#This ruby file will get new orders from pospal and save them to text file
#those text file will be printed to pdf printer and send to printer by powershell scripts

require 'digest/md5'
require 'net/http'
require 'json'
require 'date'
require 'time'
load 'router.rb'

#please set POSPAL_APPID and APPKEY in .bashrc
pospal_appid=ENV['POSPAL_APPID']
pospal_appkey=ENV['POSPAL_APPKEY']

#s_time = '2019-03-25 20:00:00'
#e_time = '2019-03-26 19:59:59'

today = Date.today
yesterday = Date.today.prev_day

today = Date.today
yesterday = today.prev_day
close_time = Time.parse today.strftime('%Y-%m-%d') + ' 16:10:00'
right_now = Time.now
s_time = yesterday.strftime('%Y-%m-%d') + ' 16:10:00'
e_time = today.strftime('%Y-%m-%d') + ' 16:09:59'
if ( right_now > close_time )
  s_time = today.strftime('%Y-%m-%d') + ' 16:10:00'
  e_time = today.strftime('%Y-%m-%d') + ' 23:59:59'
end

request_body = {
    'appId'=> pospal_appid,
    'startTime'=> s_time,
    'endTime'=> e_time
}

uri = URI('https://area24-win.pospal.cn:443/pospal-api2/openapi/v1/orderOpenApi/queryOrderPages')
res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
  req = Net::HTTP::Post.new(uri)
  req['User-Agent']= 'openApi'
  req['Content-Type']= 'application/json; charset=utf-8'
  req['accept-encoding']= 'gzip,deflate'
  req['time-stamp']= Time.now.getutc
  req['data-signature']= Digest::MD5.hexdigest(pospal_appkey + request_body.to_json)
  req.body = request_body.to_json
  http.request(req)
end

orders = JSON.parse(res.body)['data']['result']

orders.each do |order|

    next if order['state'] == 3 #skip canceled order print

    #add header twice
    content  = "                                   每一天,更安心的选择\n"
    content += "\n"

    # remove '104' from the tail
    content += "订单##{order['orderNo'][0..order['orderNo'].length-4]}    #{order['orderDateTime']}\n"
    content += "> " + order['orderNo'] + "-" + order['customerNumber'] + "\n"


    if order['state']!= 4
      order_state={0=>'初创建',1=>'已同步',2=>'已发货',3=>'已取消',4=>'已完成'}[order['state']]
      pay_method={'Cash'=>'现金','CustomerBalance'=>'余额','Wxpay'=>'微信','Alipay'=>'支付宝'}[order['payMethod']]
      delivery_type={0=>'自营',1=>'自助',2=>'自提',3=>'预约',4=>'三方'}[order['deliveryType']]
      pay_online={0=>'未用',1=>'通过'}[order['payOnLine']]
      opay_completed={0=>'还未',1=>'已经'}[order['isOnlinePaymentCompleted']]
      content += "> 状态#{order_state.nil? ? '未知' : order_state} #{pay_method}支付 #{pay_online}网付 #{opay_completed}完成 #{delivery_type}"
    end
    content +="\n"


    fat_addr = order['contactAddress'].gsub(" ","")
    slim_addr=fat_addr.gsub("\u5E7F\u4E1C\u7701\u5E7F\u5DDE\u5E02","\u5E7F\u5DDE")

    content += "#{slim_addr}\n"
    content += "#{order['contactName']}    #{order['contactTel']}\n"
    content += "> #{order['orderRemark']}\n"
    content += "\n"
    content += "#{decide_route slim_addr} [   ]                _____ of  1  2  ____\n"

    content += "-----------------------------------------------------------------\n"
    content += "##{order['orderNo'][0..order['orderNo'].length-4]}    #{order['orderDateTime']}\n"
    content +=  order['orderNo'] + "-" + order['customerNumber'] + "\n"
    content += "\n"
    content += "#{order['contactAddress'].strip}\n"
    content += "#{order['contactName']}    #{order['contactTel']}\n"
    content += "> #{order['orderRemark']}\n"
    content += "\n"
    content += "#{decide_route slim_addr} [   ]                _____ of  1  2  ____\n"

    if order['state']!= 4
      content += ">>>>>>>>>警告：非常规状态，需单独处理<<<<<<<<<\n"
    else
      content += "-----------------------------------------------------------------\n"
    end
    content += "数量 核对 商品名及规格\n"
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

    fn_name = ".\\incoming\\" + order['orderNo'] + "-" + order['customerNumber'] + ".txt"
    File.open(fn_name,"w:UTF-8") do |f|
        f.write content
    end
end

#addr = orders[19]['contactAddress']
