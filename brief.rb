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

ap res.body

orders = JSON.parse(res.body)['data']['result']
index = 0
lines = ['[Z]','[C]','[G]','[Q]','[P]','[K]']
routes = {}
lines.each do  |line|
  routes[line] = {}
end

puts routes['Z']
puts routes['C']

orders.each do |order|
    next if order['state'] == 3
    content = "orders[#{index}] #{order['orderDateTime']} ##{order['orderNo']} #{order['contactAddress'].strip} #{order['contactName']}  #{order['contactTel']}\n"
    addr = "#{order['contactName']}  #{order['contactTel']} | #{order['orderRemark']} \n #{order['contactAddress'].strip}\n"
    if order['state']!= 4
      order_state={0=>'初创建',1=>'已同步',2=>'已发货',3=>'已取消',4=>'已完成'}[order['state']]
      pay_method={'Cash'=>'现金','CustomerBalance'=>'余额','Wxpay'=>'微信','Alipay'=>'支付宝'}[order['payMethod']]
      delivery_type={0=>'自营',1=>'自助',2=>'自提',3=>'预约',4=>'三方'}[order['deliveryType']]
      pay_online={0=>'未用',1=>'通过'}[order['payOnLine']]
      opay_completed={0=>'还未',1=>'已经'}[order['isOnlinePaymentCompleted']]
      content += "异常警告>>> 状态#{order_state.nil? ? '未知' : order_state} #{pay_method}支付 #{pay_online}网付 #{opay_completed}完成 #{delivery_type}\n"
      addr += " >>#{order_state.nil? ? '未知' : order_state} #{pay_method}支付 #{pay_online}网付 #{opay_completed}完成 #{delivery_type}\n"
    end

    line = decide_route addr
    routes[line].store(order['contactTel'],addr)

    index +=1 
    puts content
end
puts "Total: " + s_time + "--" + e_time + " >>" + " #{orders.count}"

#metrics.sort_by {|_key, value| value}.to_h
  # ==> {"siteb.com" => 9, "sitec.com" => 10, "sitea.com", 745}

rday =Date.today.strftime('%Y-%m-%d')
rtime=Time.now.strftime("%H%M%S")
lines.each do  |line|
  rdex = 1
  content = "\n\n\n>>>>>>>>>>  派线单 #{line} <<<<<<<<<<\n #{Time.now.to_s}\n\n"
  routes[line].sort_by{|_key, value| value}.to_h.each { |tel, addr|
    content += "#{rdex}) " + addr
    rdex +=1
  }
  fn_name = ".\\incoming\\" + rday + "-line-" + line[1] + "-" + rtime + ".txt"
  if routes[line].size!= 0 
    File.open(fn_name,"w:UTF-8") do |f|
        f.write content
    end
  end 
end



