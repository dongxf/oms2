#This file will award points to commenter

require 'date'
require 'time'
require 'pg'

load 'get_orders.rb'
load 'user_api.rb'
load 'wechat_api.rb'
load 'pospal_api.rb'

def should_award commenter
    return false
end

def award_point_to uid, point
    req = { 'customerUid' => uid, 'balanceIncrement' => 0.00, 'pointIncrement' => point, 'dataChangeTime' => now }
    pospal_api :updateBiPi, req
end

def ms_test
    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])
    sql = 'select * from ogoods.wechat_fans'
    res = rds.query(sql)
    res.each { |r| p r['nick_name'] }
end

def pg_test
    connect = PG::connect(host: 'rdsagent.foodtrust.cn', user: "postgres", password: ENV['PSI_PASSWORD'], dbname: "commento", port: "1403" )
    results = connect.exec("select * from comments")
    results.each{|result| p result["commenterhex"] }
    connect.finish
end

def send_points_notice openids
    notice = {
        touser: 'owHN1t0ETyOD1p_J324Gcb9twHuk',
        template_id:  'RTPLTnnAvu-jI7fsAoWu0CwLpGZwoMBXK3bRlIxrkU8',
        url:  'https://foodtrust.cn/',  
        data:  {
            first:  { value:  "这是测试，无论多少积分，你都要当做过眼云烟\n啊啊啊！(这是纯测试！)", color:  '#173177' },
            keyword1:  { value:   "#{Time.now}", color:  '#173177' },
            keyword2:  { value:  '200分', color:  '#ff0000' },
            keyword3:  { value:  '撰写丰巢动态见证评论，点击详情可查看', color:  '#173177' },
            keyword4:  { value:  '1200分', color:  '#0000ff' },
            remark:  { value: "购买过该产品的用户有双倍积分\n没有购买过的用户加油哈哈哈\n\nFOODTRUST 丰巢有机\n每一天更安心的选择", color:  '#88b04b' },
        }
    }
    wat = wechat_access_token
    openids.each do |openid|
        notice.store('touser',openid)
        wechat_api :sendTemplateMessage, wat, notice
    end
end

#insert data into msqly: post_id, goods_code, good_name, last_buy_date, openid, tel, invited_times, reviewed_times
#创建一个商品介绍，缩写为Cnnnnnnn-M20002370，如C0110050
#tag review tag
#系统自动创建一个静态页面，将购买过的用户信息都放进去
#共同见证和支持的力量：有人，有商品，有用户，有农夫语，有评论，点击可前往购买
def generate_review_invitation pospal_id, magento_id, post_id, buy_link
end

openids =  [   
    #'owHN1t0MhAd0Hv7KVwEhz65fBN-8', 'owHN1txf-Kpa8uwxAql7aLY67FAY', 'owHN1t60DTAxWPmo5LHlMEFQ1d5o', 'owHN1t99CmqMZ3MVk11xdF2z_tG0', 'owHN1t3GUvWYmKsxbwZdSpQDo4O4', 'owHN1t_RLY8FAHQpOa3GdXVoI6DM',
    'owHN1t0ETyOD1p_J324Gcb9twHuk'
]

send_points_notice openids
pg_test
ms_test
