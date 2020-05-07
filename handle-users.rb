#This file will manipulate points and balance rebate to users

require 'date'
require 'time'
require 'awesome_print'

load 'get_orders.rb'
load 'user_api.rb'
load 'wechat_api.rb'
load 'rds_api.rb'

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

def prepare_users_list conditions
    list=[]
    sqlu = "select openid, uid, name, phone from ogoods.pospal_users #{conditions}"
    res = @rds.query sqlu
    res.each do |r|
        #传数据，尤其涉及到通过JSON文件转储存，不要用:openid，用"openid"的形式，否则:openid存进去，"openid"读出来
        list += [ { "openid" => r['openid'], "uid" => r['uid'], "name" => r['name'], "phone" => r['phone'] } ]
    end
    return list
end

def give_points list, points, reason, url

  list.each do |el|

      uid = ''
      openid = ''
      name = ''
      phone = ''

      uid = el["uid"]
      openid = el["openid"]
      name = el["name"]
      phone = el["phone"]

      puts "give #{points} points to uid #{uid} #{name} with openid# #{openid}"
      #next if phone != '13600060044'

      req = { 'customerUid' => uid, 'balanceIncrement' => 0.0, 'pointIncrement' => points, 'dataChangeTime' => Time.now }
      res = pospal_api :updateBiPi, req
      if res['status'] == 'success'
          puts "sending notice"
          res = send_specific_points_notice openid, "#{points}分", reason, url, "#{name}, 您的账户余额有变动，详情如下", res['data']['pointAfterUpdate'].to_s
          if res["errmsg"].include? 'subscribe'
            puts "#{openid} #{name} has been left"
            unsubscribeOpenid openid 
          end
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
          res = send_specific_points_notice openid, "#{points}分", reason, "https://foodtrust.cn/a20190711/", "您的账户余额有变动，详情如下", res['data']['pointAfterUpdate'].to_s
          unsubscribeOpenid openid if res["errmsg"].include? 'subscribe'
          sqlu = "update ogoods.pospal_orders 
                  set rebate_comment='#{reason} at #{Time.now}', point_rebated=#{sprintf('%.2f',points)}  
                  where uid = #{uid} and need_rebate > 0 and point_rebated = 0 and order_time < '2019-07-11 00:00:00'"
          res = @rds.query sqlu
      else
          puts "updating BiPi error for #{openid}"
      end
  end
end

=begin
  丰巢5周年庆，每个有效客户送500积分
  因未考虑到银豹接口限制次数的问题，暂时只发到出去了一部分会员，分别保存为
  give200506-all.json
  give200506-remained.json
=end
def give_20200506

  list = prepare_users_list "where openid != '' and openid is not NULL and ignored = 0 and unsubscribed = 0"
  fn = "give-points.json"
  File.open(fn,"w:UTF-8") { |f| f.write list.to_json }
  ap list
  give_points list, 500, '共贺丰巢五周年赠送积分, 6-8日订单赠送有机好物，5=12日订单双倍积分', 'https://foodtrust.cn/wx/5A-1'
end

#为失误验证json数据
def verify_json
  list_all = JSON.parse IO.readlines("give200506-all.json")[0]
  list_remained = JSON.parse IO.readlines("give200506-remained.json")[0]
  puts list_all.size, list_remained.size, list_all.size - list_remained.size #numer of users already gave
  list_given = list_all - list_remained
  ap list_given
end

def unsubscribeOpenid openid
  sql = "update ogoods.pospal_users set unsubscribed = 1 where openid='#{openid}'"
  puts "setting openid# #{openid} in pospal_users as unsubscribed..."
  queryRds sql
end


#读取未发送数据
def patch_20200506
  list_remained = JSON.parse IO.readlines("give200506-remained.json")[0]
  list_a = list_remained[0..499]
  p list_remained.size
  p list_a.size
  p list_b.size
end

#已执行
def patch_20200506_A
  list_remained = JSON.parse IO.readlines("give200506-remained.json")[0]
  list_a = list_remained[0..599]
  give_points list_a, 500, '共贺丰巢五周年赠送积分, 6-8日随订单赠送有机好物，5=12日订单双倍积分', 'https://foodtrust.cn/wx/5A-1'
end

#已执行，发现接口数量不足，未发送部分已移入give200507-remained.json
def patch_20200506_B
  list_remained = JSON.parse IO.readlines("give200506-remained.json")[0]
  send_list = list_remained[600..list_remained.size-1]
  give_points send_list, 500, '共贺丰巢五周年赠送积分, 6-8日随订单赠送有机好物，5=12日订单双倍积分', 'https://foodtrust.cn/wx/5A-1'
end

#测试直接发送
def test_give_points
  list = prepare_users_list "where openid != '' and phone like '13600060044%'"
  fn = "give-points-test.json"
  File.open(fn,"w:UTF-8") { |f| f.write list.to_json }
  list = JSON.parse IO.readlines("give-points-test.json")[0]
  ap list
  give_points list, 500, '共贺丰巢五周年赠送积分, 6-8日订单赠送有机好物，5=12日订单双倍积分', 'https://foodtrust.cn/wx/5A-1'
end

# 测试微信消息
def test_wechat_message
  openid = 'owHN1t0ETyOD1p_J324Gcb9twHuk'
  res = send_specific_points_notice openid, "123分", "原因", "https://foodtrust.cn/wx/5A-1", "纯测试, 您的账户余额有变动，详情如下", "456分"
  ap res
  unsubscribeOpenid openid if res["errmsg"].include? 'subscribe'
  res = send_text_message openid, '昨天推送的消息格式有误，请点这里<a href="https://foodtrust.cn/wx/5A-1">查看详情</a>'
  ap res
end

# 补发节庆通知
def send_notice_I
  openids = []
  list = prepare_users_list "where openid != '' and openid is not NULL and ignored = 0"# and unsubscribed = 0"
  list.each do |li|
    openids += [li["openid"]]
  end
  openids.each do |openid|
    if openid == 'owHN1t0ETyOD1p_J324Gcb9twHuk'
      res = send_text_message openid, '如果没有补上一条推文的坑：<a href="https://foodtrust.cn/wx/5A-1">详情</a> :)'
      #ap res # "errmsg" => "response out of time limit or subscription is canceled hint: [5g.OGa0139d437]"
      puts( (res["errmsg"].include? 'subscription' ) ? 'x' : '.')
    end
  end
end

#待处理
def patch_5A_III
  send_list = JSON.parse IO.readlines("give200507-remained.json")[0]
  puts send_list.size
  #give_points send_list, 500, '共贺丰巢五周年赠送积分, 6-8日随订单赠送有机好物，5=12日订单双倍积分', 'https://foodtrust.cn/wx/5A-1'
end
