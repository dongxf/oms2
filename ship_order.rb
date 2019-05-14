#encoding: utf-8
#this file shows all orders

require 'digest/md5'
require 'net/http'
require 'json'
require 'date'
require 'awesome_print'

#please set POSPAL_APPID and APPKEY in .bashrc
def set_order_by_number action, number
        pospal_appid=ENV['POSPAL_APPID']
        pospal_appkey=ENV['POSPAL_APPKEY']
        request_body = {
            'appId'=> pospal_appid,
            #'orderNo'=> '19032703082989286104'
            'orderNo'=> number+'104'
        }

        #if action=:ship
        uri = URI('https://area24-win.pospal.cn:443/pospal-api2/openapi/v1/orderOpenApi/shipOrder') if action==:ship
        uri = URI('https://area24-win.pospal.cn:443/pospal-api2/openapi/v1/orderOpenApi/completeOrder') if action==:complete

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
end

