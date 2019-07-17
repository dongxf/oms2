#This file will rebate existed orders to users

require 'date'
require 'time'
require 'awesome_print'

load 'get_orders.rb'
load 'user_api.rb'
load 'wechat_api.rb'

p 'usage: ruby rebateOrders.rb'

def get_rebate_list rds
    #return [ {:rebate_points => 1000.0, :openid => 'owHN1t0ETyOD1p_J324Gcb9twHuk', :uid => 965193016323785568 }, {:rebate_points =>   50.0, :openid => 'owHN1t0ETyOD1p_J324Gcb9twHuk', :uid => 965193016323785568 } ]

    list=[]
    sqlu = "select sum(need_rebate) as rebate_total, openid, uid from ogoods.pospal_orders where need_rebate > 0 and point_rebated = 0 and order_time < '2019-07-11 00:00:00' group by openid"
    res = rds.query sqlu
    res.each do |r|
        list += [ {:rebate_points => r['rebate_total'] * 100 , :openid => r['openid'], :uid => r['uid'] } ]
    end
    return list
end

rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])
list = get_rebate_list rds

reason = "对2019年7月10日前有漏打折商品的订单，统一通过积分返回相应补贴"
list.each do |el|
    uid = el[:uid]
    balance = 0.0
    openid = el[:openid]
    points = el[:rebate_points]
    req = { 'customerUid' => uid, 'balanceIncrement' => balance, 'pointIncrement' => points, 'dataChangeTime' => Time.now }
    puts "updating BiPi"
    res = pospal_api :updateBiPi, req
    if res['status'] == 'success'
        puts "sending notice"
        send_specific_points_notice openid, "#{points}分", reason, "https://foodtrust.cn/a20190711/", "您的账户余额有变动，详情如下"
        sqlu = "update ogoods.pospal_orders 
                set rebate_comment='#{reason} at #{Time.now}', point_rebated=#{sprintf('%.2f',points)}  
                where uid = #{uid} and need_rebate > 0 and point_rebated = 0 and order_time < '2019-07-11 00:00:00'"
        res = rds.query sqlu
    else
        puts "updating BiPi error for #{openid}"
    end
end
