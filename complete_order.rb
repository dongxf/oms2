#encoding: utf-8
#this file shows all orders

require 'digest/md5'
require 'net/http'
require 'json'
require 'date'
require 'awesome_print'

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
    :appId => pospal_appid,
    :orderNo => '19032703082989286104',
    :shouldAddTicket => true
}

uri = URI('https://area24-win.pospal.cn:443/pospal-api2/openapi/v1/orderOpenApi/completeOrder')
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

ap JSON.parse(res.body)
