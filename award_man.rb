#This file will award points to commenter

require 'date'
require 'time'
require 'pg'
require 'awesome_print'

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

def award_customer_by_uid uids, point, reason
    uids.each do |uid| 
        openid = get_openid_by_uid(uid)
        puts "awarding cuid #{uid} with #{point}p..."
        req = { 'customerUid' => uid, 'balanceIncrement' => 0.0, 'pointIncrement' => point, 'dataChangeTime' => Time.now }
        res = pospal_api :updateBiPi, req
        ap res
        if res['status'] == 'success'
            puts "update BiPi GOOD, sending msg"
            send_specific_points_notice openid, point, reason, 'https://foodtrust.cn/a20190711/'
        else
            puts "update BiPi FAILED"
        end
    end
end

def uids_have_orders
    uids = []
    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])
    sqlu = "select uid from ogoods.pospal_orders group by uid"
    res = rds.query(sqlu)
    res.each do |r|
        uids += [ r['uid'] ]
    end
    return uids
end

#insert data into msqly: post_id, goods_code, good_name, last_buy_date, openid, tel, invited_times, reviewed_times
#创建一个商品介绍，缩写为Cnnnnnnn-M20002370，如C0110050
#tag review tag
#系统自动创建一个静态页面，将购买过的用户信息都放进去
#共同见证和支持的力量：有人，有商品，有用户，有农夫语，有评论，点击可前往购买
def generate_review_invitation pospal_id, magento_id, post_id, buy_link
end

=begin
    'owHN1t0MhAd0Hv7KVwEhz65fBN-8', 
    'owHN1txf-Kpa8uwxAql7aLY67FAY', 
    'owHN1t60DTAxWPmo5LHlMEFQ1d5o', 
    'owHN1t99CmqMZ3MVk11xdF2z_tG0', 
    'owHN1t3GUvWYmKsxbwZdSpQDo4O4', #庞建全
    'owHN1t_RLY8FAHQpOa3GdXVoI6DM',
    'owHN1t0ETyOD1p_J324Gcb9twHuk', #董学锋
    'owHN1tybpxMT4hKO8167ouWJjuiM', #邓宇虹
    'owHN1t6e-heZydDZDAaOx-1VZpFk'  #有凤来仪
    'owHN1t-k_JVJBzvI-iqFzl8miUJw', #霞女士
openids = [ 'owHN1t0ETyOD1p_J324Gcb9twHuk' ]
send_points_notice openids
=end

avoided_uids = [
    1009037249495472884,
    1048499026482618445,
    1063519358070424934,
    142886309997235545,
    147662480809713937,
    16792689893207733,
    169675655794225530,
    227436188072119765,
    247738792439758552,
    25400512841826788,
    377377989387054720,
    435843654573977446,
    478137862877704782,
    530736910498933704,
    56299318598132460,
    606279562048122110,
    628559793878451218,
    642552711720576776,
    662560813479380800,
    738479673966941048,
    810791209821523082,
    846545909407264586,
    851007562155276952,
    938952386434297186,
    943729362906451086,
    946223111440761711,
    947718076798512932,
    960332509663342177
]

all_uids = uids_have_orders
p all_uids.size

uids = all_uids - avoided_uids
p uids.size

reason = '很抱歉因后台操作失误，系统刚才向部分上半年有订单的客户推送了错误的积分和余额变动消息，如有打扰请多谅解！随致歉为您送上100积分供结账抵扣之用。您的账户一切正常，请放心使用，任何问题请咨询丰巢小蜜'
award_customer_by_uid uids, 100, reason
