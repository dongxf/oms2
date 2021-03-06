﻿#encoding: utf-8
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
    :sendTemplateMessage => "cgi-bin/message/template/send?access_token=#{wat}",
    :sendTextMessage => "cgi-bin/message/custom/send?access_token=#{wat}"
  }
  base = 'https://api.weixin.qq.com/'
  url = base + apiURLs[api_name]

  res = RestClient.post url, data.to_json
  return JSON.parse res.body
end

#
def send_bot_message content, list
    #content =   "今日丰巢实时新增用户反馈<font color=\"warning\">132例</font>，请相关同事注意。\n >类型:<font color=\"comment\">用户反馈</font> \n >普通用户反馈:<font color=\"comment\">117例</font> \n >VIP用户反馈:<font color=\"comment\">15例</font>" 
    data = {
        "msgtype": "markdown",
        "markdown": {
            "content": content,
            "mentioned_list": list
        }
    }

    res = RestClient.post ENV['WWBOT_WC'], data.to_json
    return JSON.parse res.body
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
            remark:  { value: "FOODTRUST® 丰巢有机\n让健康和友善触手可及", color:  '#88b04b' },
        }
    }
    openids.each do |openid|
        notice.store(:touser,openid) #注意，如果是'touser' 就不工作了
        res = wechat_api :sendTemplateMessage, wechat_access_token, notice
        ccNotice notice
    end
end

def send_specific_points_notice openid, points, reason, url, content, newPoints
    notice = {
        touser: 'owHN1t0ETyOD1p_J324Gcb9twHuk',
        template_id:  'RTPLTnnAvu-jI7fsAoWu0CwLpGZwoMBXK3bRlIxrkU8',
        url:  'https://shop.foodtrust.cn/m/accountv4',  
        data:  {
            first:  { value:  "您的会员积分有变动，详情如下", color:  '#173177' },
            keyword1:  { value:   "#{Time.now}", color:  '#173177' },
            keyword2:  { value:  '200分', color:  '#ff0000' },
            keyword3:  { value:  "见证诚信，传播友善，记录真实。\n积分规则：\n参与平台每篇文章讨论最多可获一次积分\n *单项正常留言50分\n *全平台首次留言200积分\n *关联购买顾客留言200分\n *按最高分值项计算", color:  '#173177' },
            keyword4:  { value:  newPoints, color:  '#0000ff' },
            remark:  { value: "点击详情获得更多分享\nFOODTRUST® 让健康和友善触手可及", color:  '#88b04b' },
        }
    }

    notice.store(:touser,openid) #注意，如果是'touser' 就不工作了
    notice.store(:url,url)
    notice[:data].store(:first, {value: content, color: '#173177'})
    notice[:data].store(:keyword2, {value: points, color: '#ff0000'})
    notice[:data].store(:keyword3, {value: reason, color: '#173177'})
    res = wechat_api :sendTemplateMessage, wechat_access_token, notice

    ccNotice notice

    return res
end

def ccNotice notice
  return
  notice.store(:touser,'owHN1tzPJOSQ2qlnbRCSo-Ke6G9k') #CC to 丰巢小蜜
  wechat_api :sendTemplateMessage, wechat_access_token, notice
  notice.store(:touser,'owHN1t0ETyOD1p_J324Gcb9twHuk') #CC to 董学锋
  wechat_api :sendTemplateMessage, wechat_access_token, notice
  notice.store(:touser,'owHN1t3GUvWYmKsxbwZdSpQDo4O4') #CC to 庞建全
  wechat_api :sendTemplateMessage, wechat_access_token, notice
end

def send_text_message openid, content
    notice = {
        touser: 'owHN1t0ETyOD1p_J324Gcb9twHuk',
        msgtype: 'text',
        text: {
            content: 'Hello,World'
        }
    }
    notice.store(:touser,openid) #注意，如果是'touser' 就不工作了
    notice[:text].store(:content,content)
    res = wechat_api :sendTextMessage, wechat_access_token, notice
    return res
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
            remark:  { value: "关注微信公号foodtrust联系客服\nFOODTRUST® 丰巢有机\n让健康和友善触手可及", color:  '#88b04b' },
        }
    }

    notice.store(:touser,openid) #注意，如果是'touser' 就不工作了
    notice.store(:url,url)
    notice[:data].store(:first, {value: content, color: '#173177'})
    notice[:data].store(:keyword3, {value: reason, color: '#173177'})
    notice[:data].store(:keyword4, {value: balance, color: '#0000ff'})
    res = wechat_api :sendTemplateMessage, wechat_access_token, notice

    ccNotice notice
    return res

end

def send_confirm_notice openid, info, order_number, order_type, remark, url, flag
    notice = {
        touser: 'owHN1t0ETyOD1p_J324Gcb9twHuk',
        template_id:  'mYo2eI-KIN9FwW3vQSG3L34valYzs87eZx97mEfQvsA',
        url:  'https://foodtrust.cn/first-order-qna/',
        data:  {
            first:  { value:  "【客户名】您好，订单已收到，我们将按团购商品说明为您如期安排配送或产地直发。", color:  '#173177' },
            keyword1:  { value:   "订单号", color:  '#173177' },
            keyword2:  { value:  '配送类型', color:  '#ff0000' },
            remark:  { value: "任何问题请联系丰巢小蜜18998382701，微信同号。\nFOODTRUST® 丰巢有机\n让健康和友善触手可及", color:  '#88b04b' },
        }
    }

    notice.store(:touser,openid) #注意，如果是'touser' 就不工作了
    if flag == 1
        notice.store(:url,'https://foodtrust.cn/first-order-qna/')
    else
        notice.store(:url,url)
    end

    notice[:data].store(:first, {value: info, color: '#173177'})
    notice[:data].store(:keyword1, {value: order_number, color: '#173177'})
    notice[:data].store(:keyword2, {value: order_type, color: '#ff0000'})
    notice[:data].store(:remark, {value: remark, color: '#88b04b'})

    res = wechat_api :sendTemplateMessage, wechat_access_token, notice
    ccNotice notice if flag == 1 # only send 1st order to foodcherry, usually use order[:order_times]

    return res
end
