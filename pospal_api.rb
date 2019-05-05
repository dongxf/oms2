#encoding: utf-8
#this file can be used in other ruby file by loading 'pospal_api.rb'

require 'digest/md5'
require 'net/http'
require 'json'
require 'date'
require 'awesome_print'

# request_body as Hash
# return is Hash
#
# req = { 'appId'=> pospal_appid,     'orderNo'=> '19032703082989286104' }
# res = post_to_posal :shipOder, req
# puts res.body

def pospal_api api_name, request_body 
  api_urls={
    :shipOrder => 'orderOpenApi/shipOrder',
    :getCategoryPages => 'productOpenApi/queryProductCategoryPages',
    :queryOrderPages => 'orderOpenApi/queryOrderPages'
  }

  #please set POSPAL_APPID and APPKEY in .bashrc
  pospal_appid=ENV['POSPAL_APPID']
  pospal_appkey=ENV['POSPAL_APPKEY']
  base_url= 'https://area24-win.pospal.cn:443/pospal-api2/openapi/v1/'

  
  request_body.store('appId', pospal_appid)

  uri = URI(base_url+api_urls[api_name])
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

  #puts "Status: #{res.body['status']}" if res && res.body
  return JSON.parse(res.body) if !res.nil?

end
