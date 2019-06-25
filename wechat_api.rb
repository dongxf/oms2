#encoding: utf-8
#this file can be used in other ruby file by loading 'wechat_api.rb'

require 'digest/md5'
require 'net/http'
require 'json'
require 'date'
require 'awesome_print'
require "open-uri"

# request_body as Hash
# return is Hash
#
# req = { 'appId' => pospal_appid,     'orderNo' => '19032703082989286104' }
# res = post_to_posal :shipOder, req
# puts res.body

def wechat_access_token
   url = "https://foodtrust.cn/wx/get-access-token?badge=#{ENV['RDS_AGENT']}"
   data = URI.parse(url).read
   return JSON.parse(data)['access_token']
end

def wechat_api api_name, wat, request_body
  api_urls={
    :sendTemplateMessage => "cgi-bin/message/template/send?access_token=#{wat}"
  }
  base_url= 'https://api.weixin.qq.com/'
  uri = URI(base_url+api_urls[api_name])
  res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
    req = Net::HTTP::Post.new(uri)
    req.body = request_body.to_json
    http.request(req)
  end
end
