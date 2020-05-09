#encoding: utf-8

#this tool will export pospal_users into crmeb.eb_users creation sql cmds

require 'mysql2'
require 'json'
require 'awesome_print'
require 'spreadsheet' #用于写xls文件
require 'simple-spreadsheet' #用于读取xlsx文件，spreadsheet gem读xlsx会报签名错误

load 'rds_api.rb' #commitTrans queryRds

=begin
Usage:  export-users.rb [-w]
        用于生成迁移用户数据所需的SQL语句
        -w 将直接修改数据库
        没有-w 将只生成SQL语句
=end

WRITE_MODE = ARGV[0]=='-w' ? true : false

def read_pospal_users

  recs = []
  founder = {}
  inq = "select * from ogoods.pospal_users where ignored = 0" #and crmeb_uid is NULL"  #when go production add this condition!!!
  res = @rds.query(inq)

  res.each do | r |
    #rec = {}
    #basic fields
    #fields = ['uid', 'number', 'name', 'phone', 'openid', 'unionid', 'avatar', 'discount', 'raw_data', 'points', 'discount', 'balance', 'address', 'created']
    #fields.each { |f| rec[f]=r[f] }
    if r['openid'] == 'owHN1t0ETyOD1p_J324Gcb9twHuk' #为了避免1号用户某种情下况默认称为新用户的上级，可能带来的佣金问题，选定董学锋做1号用户
      founder = r
    else
      recs += [r] 
    end
  end

  puts "done. #{recs.size}"
  return [founder] + recs
end

def createSingleUserSqls user, idx

  sqls = []

  grade = 101 - user['discount']
  levels = { 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 9 => 7, 16 => 8}
  level = levels[grade]
  if level.nil?
    puts ">>>ERROR: #{idx} #{user['discount']} #{user['name']}"
    exit
  end

  memberships = { 1 => '百花蜜', 2 => '椴树蜜' , 3 => '藿香蜜', 4 => '党参蜜', 5 => '藏岩蜜', 6 => '生活家', 9 => '小伙伴', 16 => '在职工' }
  member = memberships [ grade ]

  #注意SQL中的fields需要保持在同一列中
  sqls += ["INSERT INTO crmeb.eb_user (uid, account, pwd, real_name, birthday, card_id, mark, partner_id, group_id, nickname, avatar, phone, add_time, add_ip, last_time, last_ip, now_money, brokerage_price, integral, sign_num, status, level, spread_uid, spread_time, user_type, is_promoter, pay_count, spread_count, clean_time, addres, adminid, login_type, pospal_number ) VALUES (
  #{idx}, '#{user['phone']}', '9cf9542772e8a5904acd419e51d2011d', '#{@rds.escape user['name']}', 0, '', '', 
  0, 0, '#{@rds.escape user['name']}', '#{user['avatar']}', '#{user['phone']}', 1588339658, '128.0.0.1', 1588339658, '128.0.0.1', 
  #{sprintf('%2f',user['balance'])}, 0.00, #{sprintf('%2f',user['points'])}, 0, 1, #{level}, 
  0, 0, 'wechat', 0, 0, 0, 0, '#{@rds.escape user['address']}', 0, '', '#{user['number']}'
  );"]

  sqls += ["INSERT INTO crmeb.eb_wechat_user VALUES (
  #{idx}, '#{user['unionid']}', '#{user['openid']}', NULL, '#{@rds.escape user['name']}', '#{user['avatar']}', 0, '广州', 'zh_CN', '广东', '中国', NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'wechat'
  );"]

  sqls +=  ["INSERT INTO crmeb.eb_user_level VALUES (#{idx}, #{idx}, #{level}, #{grade}, 1588552526, 1, 0, 1, '#用户#{user['name']}在#{Time.now.strftime('%Y年%m月%d日')}由系统赠送会员等级成为#{member}会员', 0, 0, 1588552526, #{user['discount']}
  );"]

  sqls += ["INSERT INTO crmeb.eb_user_task_finish (task_id, uid, status, add_time) VALUES (1, #{idx}, 1, 1588552526);"] if level > 0
  sqls += ["INSERT INTO crmeb.eb_user_task_finish (task_id, uid, status, add_time) VALUES (2, #{idx}, 1, 1588552526);"] if level > 0

  sqls += ["INSERT INTO crmeb.eb_user_task_finish (task_id, uid, status, add_time) VALUES (3, #{idx}, 1, 1588552526);"] if level > 1
  sqls += ["INSERT INTO crmeb.eb_user_task_finish (task_id, uid, status, add_time) VALUES (4, #{idx}, 1, 1588552526);"] if level > 1

  sqls += ["INSERT INTO crmeb.eb_user_task_finish (task_id, uid, status, add_time) VALUES (5, #{idx}, 1, 1588552526);"] if level > 2
  sqls += ["INSERT INTO crmeb.eb_user_task_finish (task_id, uid, status, add_time) VALUES (6, #{idx}, 1, 1588552526);"] if level > 2

  sqls += ["INSERT INTO crmeb.eb_user_task_finish (task_id, uid, status, add_time) VALUES (7, #{idx}, 1, 1588552526);"] if level > 3
  sqls += ["INSERT INTO crmeb.eb_user_task_finish (task_id, uid, status, add_time) VALUES (8, #{idx}, 1, 1588552526);"] if level > 3

  sqls += ["INSERT INTO crmeb.eb_user_task_finish (task_id, uid, status, add_time) VALUES (9, #{idx}, 1, 1588552526);"] if level > 4
  sqls += ["INSERT INTO crmeb.eb_user_task_finish (task_id, uid, status, add_time) VALUES (10, #{idx}, 1, 1588552526);"] if level > 4

  sqls += ["INSERT INTO crmeb.eb_user_task_finish (task_id, uid, status, add_time) VALUES (11, #{idx}, 1, 1588552526);"] if level > 5
  sqls += ["INSERT INTO crmeb.eb_user_task_finish (task_id, uid, status, add_time) VALUES (12, #{idx}, 1, 1588552526);"] if level > 5

  # 这里的link_id就这么填‘1’，不知状况
  sqls += ["INSERT INTO crmeb.eb_user_bill (uid, link_id, pm, title, category, type, number, balance, mark, add_time, status, take ) VALUES (
  #{idx}, '1', 1, 'FC4.0系统初始导入', 'now_money', 'system_add', #{sprintf('%2f', user['balance'])}, #{sprintf('%2f', user['balance'])}, 
  'FC3.0系统余额平移', 1588583622, 1, 0);"] if user['balance'] >= 0.01

  sqls += ["INSERT INTO crmeb.eb_user_bill (uid, link_id, pm, title, category, type, number, balance, mark, add_time, status, take ) VALUES (
  #{idx}, '1', 1, 'FC4.0系统初始导入', 'integral', 'system_add', #{sprintf('%2f',user['points'])}, #{sprintf('%2f', user['points'])}, 
  'FC3.0系统积分平移', 1588583622, 1, 0);"] if user['points'] >= 0.01

  return sqls

end

def clearCrmebUsersSqls
  return [ 
    "delete from crmeb.eb_user where 1=1;", 
    "delete from crmeb.eb_wechat_user where 1=1;",
    "delete from crmeb.eb_user_level where 1=1;",
    "delete from crmeb.eb_user_task_finish where 1=1;",
    "delete from crmeb.eb_user_bill where 1=1;" 
  ]
end

def createCrmebUsers users

  sqls = []

  sqls += clearCrmebUsersSqls

  idx = 1
  users.each do |user|
    if user['openid'] != ''
      sqls += createSingleUserSqls user, idx
      sqls += ["update ogoods.pospal_users set crmeb_uid = #{idx} where uid = #{user['uid']};"]
      idx += 1
    end
  end

  return sqls

end

puts "reading all recs from pospal..."
users = read_pospal_users

puts "save_to_excel..."
fields = ['uid', 'number', 'name', 'phone', 'openid', 'unionid', 'avatar', 'discount', 'raw_data', 'points', 'discount', 'balance', 'address', 'created']
save_to_excel fields, users, "pospal-users-all.xls"

puts "creating crmeb users..."
sqls = createCrmebUsers users
File.open("3-import-pospal-users.sql","w:UTF-8") { |f| f.write sqls.join("\n") }

commitTrans sqls if WRITE_MODE
