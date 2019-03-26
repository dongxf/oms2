#encoding: utf-8
#This ruby file will get new orders from pospal and send them to email

require 'digest/md5'
require 'net/http'
require 'net/https'
require 'uri'
require 'json'
require 'awesome_print'

#please set POSPAL_APPID and APPKEY in .bashrc
pospal_appid=ENV['POSPAL_APPID']
pospal_appkey=ENV['POSPAL_APPKEY']
s_time = '2019-03-25 20:00:00'
e_time = '2019-03-26 19:59:59'

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

    #add header twice
    content  = "\n"
    # remove '104' from the tail
    content += "订单# #{order['orderNo'][0..order['orderNo'].length-4]}    #{order['orderDateTime']}\n"
    content +=  order['orderNo'] + "-" + order['customerNumber'] + "\n\n"
    content += "#{order['contactAddress'].strip}\n"
    content += "#{order['contactName']} 电话: #{order['contactTel']}\n"
    content += "\n"
    content += "[   ]  of 【1】【2】【3】\n"
    content += "-------------------------------------\n"
    content += "\n"
    content += "订单# #{order['orderNo'][0..order['orderNo'].length-4]}    #{order['orderDateTime']}\n"
    content +=  order['orderNo'] + "-" + order['customerNumber'] + "\n\n"
    content += "#{order['contactAddress'].strip}\n"
    content += "#{order['contactName']} 电话: #{order['contactTel']}\n"
    content += "\n"
    content += "[   ]  of 【1】【2】【3】\n"
    content += "-------------------------------------\n"
    content += "\n"

    items = order['items']
    items.each do |item|
        if item['productQuantity']>1 
            qty = " >" + sprintf("%d",item['productQuantity'])
        else
            qty = "  " + sprintf("%d",item['productQuantity'])
        end
        content += "#{qty} [   ]#{item['productName']}\n"
    end

    #add footer
    content +="\n"
    content += "           >>>>>售后需知<<<<<\n"
    content += "如有缺货，24小时内为您原路退款，请留意查收\n"
    content += "售后不满意无障碍退换，小蜜微信18998382701\n"
    content += "更多服务水平说明，详情请参见foodtrust.cn\n"
    content += "          每一天，更安心的选择\n"
    content += "\n"
=begin
    content += "产品标准：蔬菜生鲜有机种植，深加工品无负面添加\n"
    content += "供应周期：农场蔬菜凌晨到店，每天配送，逢周六休息\n"
    content += "下单时间：每晚20:00至次日16:00接单，16:00停业上新\n"
    content += "周边配送：线下店周边（欧泊雅居乐）上下午各送一次\n"
    content += "广州宅配：广州城区上午9:00前订单下午18:00前送达\n"
    content += "省内快递：上午9:00前订单，当天晚上或次日上午送达\n"
    content += "售后服务：不满意无障碍退换，丰巢小蜜18998382701\n"
=end

    fn_name = ".\\incoming\\" + order['orderNo'] + "-" + order['customerNumber'] + ".txt"
    File.open(fn_name,"w:UTF-8") do |f|
        f.write content
    end
end

#addr = orders[19]['contactAddress']
