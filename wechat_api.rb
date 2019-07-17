#encoding: utf-8
#this file can be used in other ruby file by loading 'wechat_api.rb'

require 'rest-client'   #to use RestClient
require 'json'          #to use JSON
require 'awesome_print' #to use ap helper

#return hash instead of JSON string
def get_wechat_access_token
   res = RestClient.get "https://foodtrust.cn/wx/get-access-token?badge=#{ENV['RDS_AGENT']}"
   #ap res.code;  res.cookies; ap res.headers; ap res.body
   return JSON.parse(res.body)['access_token']
end

def wechat_access_token
   @wat = get_wechat_access_token if @wat.nil?
   return @wat
end

#data should be hash, not JSON string
def wechat_api api_name, wat, data
  apiURLs={
    :sendTemplateMessage => "cgi-bin/message/template/send?access_token=#{wat}"
  }
  base = 'https://api.weixin.qq.com/'
  url = base + apiURLs[api_name]

  res = RestClient.post url, data.to_json
  return true if JSON.parse(res.body)['errocode'] == 0
  return false
end

def send_balance_notice openids
    notice = {
        touser: 'owHN1t0ETyOD1p_J324Gcb9twHuk',
        template_id:  'JJq04n18SSmcNItaCwcLDmNqFJoGCIk5nvOWPm3KvJg',
        url:  'https://shop.foodtrust.cn/m/accountv4',  
        data:  {
            first:  { value:  "您的账户余额有变动，详情如下", color:  '#173177' },
            keyword1:  { value:   "会员账户余额", color:  '#173177' },
            keyword2:  { value:  '系统每日批处理', color:  '#ff0000' },
            keyword3:  { value:  "团购订单或特定区域运费返回\n运费退回规则：\n *所有已提交的团购订单（无论是否拼成）\n *特定小区大于88元的日常订单\n *广东省外快递改为到付(满298另有积分奖励)", color:  '#173177' },
            keyword4:  { value:  '+10.00', color:  '#0000ff' },
            keyword5:  { value:  '点击详情查看最新余额', color:  '#0000ff' },
            remark:  { value: "FOODTRUST® 丰巢有机\n每一天更安心的选择", color:  '#88b04b' },
        }
    }
    openids.each do |openid|
        notice.store(:touser,openid) #注意，如果是'touser' 就不工作了
        wechat_api :sendTemplateMessage, wechat_access_token, notice
        notice.store(:touser,'owHN1tzPJOSQ2qlnbRCSo-Ke6G9k') #CC to 丰巢小蜜
        wechat_api :sendTemplateMessage, wechat_access_token, notice
        notice.store(:touser,'owHN1t0ETyOD1p_J324Gcb9twHuk') #CC to 董学锋
        wechat_api :sendTemplateMessage, wechat_access_token, notice
    end
end

def send_specific_points_notice openid, points, reason, url, content
    notice = {
        touser: 'owHN1t0ETyOD1p_J324Gcb9twHuk',
        template_id:  'RTPLTnnAvu-jI7fsAoWu0CwLpGZwoMBXK3bRlIxrkU8',
        url:  'https://shop.foodtrust.cn/m/accountv4',  
        data:  {
            first:  { value:  "您的会员积分有变动，详情如下", color:  '#173177' },
            keyword1:  { value:   "#{Time.now}", color:  '#173177' },
            keyword2:  { value:  '200分', color:  '#ff0000' },
            keyword3:  { value:  "见证诚信，传播友善，记录真实。\n积分规则：\n参与平台每篇文章讨论最多可获一次积分\n *单项正常留言50分\n *全平台首次留言200积分\n *关联购买顾客留言200分\n *按最高分值项计算", color:  '#173177' },
            keyword4:  { value:  '点击详情查看变动依据及最新积分', color:  '#0000ff' },
            remark:  { value: "FOODTRUST® 丰巢有机\n每一天更安心的选择", color:  '#88b04b' },
        }
    }
    wat = wechat_access_token
    notice.store(:touser,openid) #注意，如果是'touser' 就不工作了
    notice.store(:url,url)
    notice[:data].store(:first, {value: content, color: '#173177'})
    notice[:data].store(:keyword2, {value: points, color: '#ff0000'})
    notice[:data].store(:keyword3, {value: reason, color: '#173177'})
    wechat_api :sendTemplateMessage, wechat_access_token, notice

    notice.store(:touser,'owHN1tzPJOSQ2qlnbRCSo-Ke6G9k') #CC to 丰巢小蜜
    wechat_api :sendTemplateMessage, wechat_access_token, notice
    notice.store(:touser,'owHN1t0ETyOD1p_J324Gcb9twHuk') #CC to 董学锋
    wechat_api :sendTemplateMessage, wechat_access_token, notice
end

def send_specific_balance_notice openid, balance, reason, url, content
    notice = {
        touser: 'owHN1t0ETyOD1p_J324Gcb9twHuk',
        template_id:  'JJq04n18SSmcNItaCwcLDmNqFJoGCIk5nvOWPm3KvJg',
        url:  'https://shop.foodtrust.cn/m/accountv4',  
        data:  {
            first:  { value:  "您的账户余额有变动，详情如下", color:  '#173177' },
            keyword1:  { value:   "会员账户余额", color:  '#173177' },
            keyword2:  { value:  '系统每日批处理', color:  '#ff0000' },
            keyword3:  { value:  "团购订单或特定区域运费返回\n运费退回规则：\n *所有已提交的团购订单（无论是否拼成）\n *特定小区大于88元的日常订单\n *广东省外快递改为到付(满298另有积分奖励)", color:  '#173177' },
            keyword4:  { value:  '+10.00', color:  '#0000ff' },
            keyword5:  { value:  '点击详情查看会员对账单及最新余额', color:  '#0000ff' },
            remark:  { value: "客服小蜜：18998382701（微信同号）\nFOODTRUST® 丰巢有机\n每一天更安心的选择", color:  '#88b04b' },
        }
    }
    wat = wechat_access_token
    notice.store(:touser,openid) #注意，如果是'touser' 就不工作了
    notice.store(:url,url)
    notice[:data].store(:first, {value: content, color: '#173177'})
    notice[:data].store(:keyword3, {value: reason, color: '#173177'})
    notice[:data].store(:keyword4, {value: balance, color: '#0000ff'})
    wechat_api :sendTemplateMessage, wechat_access_token, notice

    notice.store(:touser,'owHN1tzPJOSQ2qlnbRCSo-Ke6G9k') #CC to 丰巢小蜜
    wechat_api :sendTemplateMessage, wechat_access_token, notice
    notice.store(:touser,'owHN1t0ETyOD1p_J324Gcb9twHuk') #CC to 董学锋
    wechat_api :sendTemplateMessage, wechat_access_token, notice
end
