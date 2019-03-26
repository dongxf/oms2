#encoding: utf-8
#This ruby file will get new orders from pospal and save them to text file
#those text file will be printed to pdf printer and send to printer by powershell scripts

require 'digest/md5'
require 'net/http'
require 'json'
require 'date'

#please set POSPAL_APPID and APPKEY in .bashrc
pospal_appid=ENV['POSPAL_APPID']
pospal_appkey=ENV['POSPAL_APPKEY']

#s_time = '2019-03-25 20:00:00'
#e_time = '2019-03-26 19:59:59'

today = Date.today
yesterday = Date.today.prev_day
s_time = yesterday.strftime('%Y-%m-%d') + ' 19:00:00'
e_time = today.strftime('%Y-%m-%d') + ' 18:00:00'

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
    content  = "                            FOODTRUST 丰巢优选\n"
    content += "                           每一天，更安心的选择\n"
    content += "\n"
    content += "\n"

    # remove '104' from the tail
    content += "##{order['orderNo'][0..order['orderNo'].length-4]}    #{order['orderDateTime']}\n"
    content +=  order['orderNo'] + "-" + order['customerNumber'] + "\n"
    content += "#{order['contactAddress'].strip}\n"
    content += "#{order['contactName']}    #{order['contactTel']}\n"
    content += "[G] [P] [K] [Q] [Z]                ___ of  1  2  __\n"
    content += ">#{order['orderRemark']}\n"
    content += "\n"

    content += "-----------------------------------------------------------------\n"
    content += "##{order['orderNo'][0..order['orderNo'].length-4]}    #{order['orderDateTime']}\n"
    content +=  order['orderNo'] + "-" + order['customerNumber'] + "\n"
    content += "#{order['contactAddress'].strip}\n"
    content += "#{order['contactName']}    #{order['contactTel']}\n"
    content += "[G] [P] [K] [Q] [Z]                ___ of  1  2  __\n"
    content += ">#{order['orderRemark']}\n"
    content += "\n"

    content += "-----------------------------------------------------------------\n"
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
    content += "售后不满意无障碍退换，联系小蜜18998382701，微信同号\n"
    content += "              foodtrust.cn\n"
    content += "             买有机，到丰巢\n"
=begin
    content += "\n"
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
