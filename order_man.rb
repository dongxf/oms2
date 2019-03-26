#encoding: utf-8
#This ruby file will get new orders from pospal and send them to email

require 'digest/md5'
require 'net/http'
require 'net/https'
require 'uri'
require 'json'
require 'awesome_print'

#please set POSPAL_APPID in .bashrc
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
    content += "订单# #{order['orderNo']}    #{order['orderDateTime']}\n"
    content += "会员# #{order['customerNumber']}\n"
    content += "地址: #{order['contactAddress'].strip}\n"
    content += "#{order['contactName']} 电话: #{order['contactTel']}\n"
    content += "-------------------------------------\n"
    content += "\n"
    content += "订单# #{order['orderNo']}    #{order['orderDateTime']}\n"
    content += "会员# #{order['customerNumber']}\n"
    content += "地址: #{order['contactAddress'].strip}\n"
    content += "#{order['contactName']} 电话: #{order['contactTel']}\n"
    content += "-------------------------------------\n"
    content += "\n"

    items = order['items']
    items.each do |item|
        if item['productQuantity']>1 
            qty = "[  ]  >>" + sprintf("%d",item['productQuantity'])
        else
            qty = "[  ]    " + sprintf("%d",item['productQuantity'])
        end
        content += "#{qty}   #{item['productName']}\n"
    end

    #add footer
    content +="\n"
    content += "-------------------------------------\n"
    content += "丰巢有机生鲜宅配服务概述\n"
    content += "1、农场蔬菜凌晨到店，每天配送，逢周六休息\n"
    content += "2、线上商店营业时间为前晚20:00-当天16:00\n"
    content += "3、万科欧泊及南村雅居乐上下午各集中配送一次\n"
    content += "4、广州其他区域上午九点前订单下午六点前送达\n"
    content += "5、不满意无障碍退换，请联系丰巢小蜜18998382701\n"


    fn_name = ".\\incoming\\" + order['orderNo'] + "-" +order['customerNumber'] +".txt"
    File.open(fn_name,"w:UTF-8") do |f|
        f.write content
    end
end

#addr = orders[19]['contactAddress']
