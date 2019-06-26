#encoding: utf-8
#this file can be used in other ruby file by loading 'wechat_api.rb'

require 'rest-client'   #to use RestClient
require 'json'          #to use JSON
require 'awesome_print' #to use ap helper

#return hash instead of JSON string
def wechat_access_token
   res = RestClient.get "https://foodtrust.cn/wx/get-access-token?badge=#{ENV['RDS_AGENT']}"
   #ap res.code;  res.cookies; ap res.headers; ap res.body
   return JSON.parse(res.body)['access_token']
end

#data should be hash, not JSON string
def wechat_api api_name, wat, data
  apiURLs={
    :sendTemplateMessage => "cgi-bin/message/template/send?access_token=#{wat}"
  }
  base = 'https://api.weixin.qq.com/'
  url = base + apiURLs[api_name]

  res = RestClient.post url, data.to_json
  ap JSON.parse(res.body)
end
