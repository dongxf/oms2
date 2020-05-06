#This file will manipulate points and balance rebate to users

require 'date'
require 'time'
require 'awesome_print'

load 'get_orders.rb'
load 'user_api.rb'
load 'wechat_api.rb'

#p 'usage: ruby give-points.rb'

@rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD']) if @rds.nil?

def get_rebate_list

    list=[]
    sqlu = "select sum(need_rebate) as rebate_total, openid, uid from ogoods.pospal_orders where need_rebate > 0 and point_rebated = 0 and order_time < '2019-07-11 00:00:00' group by openid"
    res = @rds.query sqlu
    res.each do |r|
        list += [ {:rebate_points => r['rebate_total'] * 100 , :openid => r['openid'], :uid => r['uid'] } ]
    end
    return list
end

def prepare_list conditions
    list=[]
    sqlu = "select openid, uid, name, phone from ogoods.pospal_users #{conditions}"
    res = @rds.query sqlu
    res.each do |r|
        list += [ { :openid => r['openid'], :uid => r['uid'], :name => r['name'], :phone => r['phone'] } ]
    end
    return list
end

def give_points list, points, reason, url

  list.each do |el|

      uid = el[:uid]
      openid = el[:openid]
      name = el[:name]
      phone = el[:phone]

      #puts "give #{points} points to #{name} with openid as #{openid}"
      #next if el[:phone] != '13600060044'

      p "give #{points} points to #{name} openid = #{openid}"
      req = { 'customerUid' => uid, 'balanceIncrement' => 0.0, 'pointIncrement' => points, 'dataChangeTime' => Time.now }
      res = pospal_api :updateBiPi, req
      if res['status'] == 'success'
          puts "sending notice"
          send_specific_points_notice openid, "#{points}分", reason, url, "您的账户余额有变动，详情如下", res['data']['pointAfterUpdate'].to_s
          sqlu = "update ogoods.pospal_orders 
                  set rebate_comment='#{reason} at #{Time.now}', point_rebated=#{sprintf('%.2f',points)}  
                  where uid = #{uid} and need_rebate > 0 and point_rebated = 0 and order_time < '2019-07-11 00:00:00'"
          res = @rds.query sqlu
      else
          puts "updating BiPi error for #{name} #{openid}"
      end

  end

end

def rebate_20190710
  list = get_rebate_list
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
          send_specific_points_notice openid, "#{points}分", reason, "https://foodtrust.cn/a20190711/", "您的账户余额有变动，详情如下", res['data']['pointAfterUpdate'].to_s
          sqlu = "update ogoods.pospal_orders 
                  set rebate_comment='#{reason} at #{Time.now}', point_rebated=#{sprintf('%.2f',points)}  
                  where uid = #{uid} and need_rebate > 0 and point_rebated = 0 and order_time < '2019-07-11 00:00:00'"
          res = @rds.query sqlu
      else
          puts "updating BiPi error for #{openid}"
      end
  end
end


#丰巢5周年庆，每个有效客户送500积分
def give_20200506

  list = prepare_list "where openid != '' and openid is not NULL and ignored = 0"
  fn = "give-points.json"
  File.open(fn,"w:UTF-8") { |f| f.write list.to_json }
  ap list

  #因未考虑到银豹接口限制次数的问题，暂时只发到出去了一部分会员，分别保存为
  #give200506-all.json
  #give200506-remained.json

  #give_points list, 500, '共贺丰巢五周年赠送积分', 'https://foodtrust.cn/wx/5A-1'
end

#为失误验证json数据
def verify_json
  list_all = JSON.parse IO.readlines("give200506-all.json")[0]
  list_remained = JSON.parse IO.readlines("give200506-remained.json")[0]
  puts list_all.size, list_remained.size, list_all.size - list_remained.size #numer of users already gave
end

verify_json
