#encoding: utf-8
#this file shows all orders

require 'digest/md5'
require 'net/http'
require 'json'
require 'time'
require 'date'
require 'awesome_print'

load 'router.rb'

#please set POSPAL_APPID and APPKEY in .bashrc
pospal_appid=ENV['POSPAL_APPID']
pospal_appkey=ENV['POSPAL_APPKEY']

#s_time = '2019-03-25 20:00:00'
#e_time = '2019-03-26 19:59:59'

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
#ap res.body

orders = JSON.parse(res.body)['data']['result']
lines = ['[Z]','[C]','[G]','[Q]','[P]','[K]']
routes = {}
lines.each do  |line|
  routes[line] = {}
end

puts routes['Z']
puts routes['C']

index = -1
amt = 0.0
good_orders = 0
orders.each do |order|
    index +=1 
    amt += order['totalAmount'] if order['state'] != 3
    good_orders +=1 if order['state'] == 4
    fat_addr = order['contactAddress'].gsub(" ","")
    slim_addr=fat_addr.gsub("\u5E7F\u4E1C\u7701\u5E7F\u5DDE\u5E02","\u5E7F\u5DDE")

    addr = "#{slim_addr} #{order['contactName']}  #{order['contactTel']} | #{order['orderRemark']} \n"
    if order['state']!= 4
      order_state={0=>'初创建',1=>'已同步',2=>'已发货',3=>'已取消',4=>'已完成'}[order['state']]
      pay_method={'Cash'=>'现金','CustomerBalance'=>'余额','Wxpay'=>'微信','Alipay'=>'支付宝'}[order['payMethod']]
      delivery_type={0=>'自营',1=>'自助',2=>'自提',3=>'预约',4=>'三方'}[order['deliveryType']]
      pay_online={0=>'未用',1=>'通过'}[order['payOnLine']]
      opay_completed={0=>'还未',1=>'已经'}[order['isOnlinePaymentCompleted']]
      addr += " >>#{order_state.nil? ? '未知' : order_state} #{pay_method}支付 #{pay_online}网付 #{opay_completed}完成 #{delivery_type}\n"
    end

    line = decide_route addr
    routes[line].store(order['contactTel'],addr)

    #puts content
end


rday =Date.today.strftime('%Y-%m-%d')
rtime=Time.now.strftime("%H%M%S")
lines.each do  |line|
  rdex = 1
  content = ">>>>>>>>>>  Route #{line} <<<<<<<<<<\n"
  routes[line].sort_by{|_key, value| value}.to_h.each { |tel, addr|
    content += "#{rdex}) " + addr
    rdex +=1
  }
  if routes[line].size!= 0 
    puts content
  end 
end






puts "------------------------------------"
puts "Total: " + s_time + "--" + e_time + " >>" + " #{good_orders} of #{orders.count} RMB#{amt}"
