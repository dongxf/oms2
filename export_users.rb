#encoding: utf-8

#this tool will export pospal_users into crmeb

require 'mysql2'
require 'json'
require 'awesome_print'
require 'spreadsheet' #用于写xls文件
require 'simple-spreadsheet' #用于读取xlsx文件，spreadsheet gem读xlsx会报签名错误

@rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])

def read_pospal_users

  recs = []

  inq = "select * from ogoods.pospal_users where ignored = 0"
  res = @rds.query(inq)

  res.each do | r |
    rec = {}
    #basic fields
    fields = ['uid', 'number', 'name', 'phone', 'openid', 'unionid', 'avatar', 'discount', 'raw_data', 'points', 'discount', 'balance', 'address', 'created']
    fields.each { |f| rec[f]=r[f] }
    #ap rec if rec['phone'].include? '136000600'  #just check
    recs += [rec]
  end

  puts "done. #{recs.size}"
  return recs
end

def save_to_excel names, items, fn

  Spreadsheet.client_encoding="utf-8"
  book = Spreadsheet::Workbook.new
  sheet = book.create_worksheet :name => "sheet"

#生成表头
  colIndex=0 #col index
  names.each do |name|
    sheet.row(0)[colIndex]=name
    colIndex += 1
  end

  lineIndex = 1
  items.each do |item|
    colIndex=0
    names.each do |name|
      sheet.row(lineIndex)[colIndex] = item[name]
      colIndex +=1
    end
    lineIndex += 1
  end

  book.write fn
  puts "done. #{items.size}"
end

def gen_user_sql user, idx

  sql = ''
  rtime=Time.now.strftime("%H%M%S")
  grade = 101 - user['discount']
  levels = { 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 9 => 7, 16 => 8}
  level = levels[grade]
  if level.nil?
    puts "error: #{idx} #{user['discount']} #{user['name']}"
    return
  end

  memberships = { 1 => '百花蜜', 2 => '椴树蜜' , 3 => '藿香蜜', 4 => '党参蜜', 5 => '藏岩蜜', 6 => '生活家', 9 => '小伙伴', 16 => '在职工' }
  member = memberships [ grade ]

  sql += "INSERT INTO `eb_user` VALUES (
    #{idx}, '#{user['phone']}', 'e10adc3949ba59abbe56e057f20f883e', '#{@rds.escape user['name']}', 0, '', '', 0, 0, '#{@rds.escape user['name']}', '#{user['avatar']}', '#{user['phone']}', 1588339658, '119.33.194.224', 1588339658, '119.33.194.224', #{sprintf('%2f',user['balance'])}, 0.00, #{sprintf('%2f',user['points'])}, 0, 1, #{level}, 0, 0, 'wechat', 0, 0, 0, 0, '#{@rds.escape user['address']}', 0, ''
  );"
  sql += "INSERT INTO `eb_wechat_user` VALUES (
    #{idx}, '#{user['unionid']}', '#{user['openid']}', NULL, '#{@rds.escape user['name']}', '#{user['avatar']}', 0, '广州', 'zh_CN', '广东', '中国', NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'wechat'
  );"
  sql +=  "INSERT INTO `eb_user_level` VALUES (#{idx}, #{idx}, #{level}, #{grade}, 1588552526, 1, 0, 1, '#用户#{user['name']}在#{rtime}由系统赠送会员等级成为#{member}会员', 0, 0, 1588552526, #{user['discount']});
  "
  sql += "
    INSERT INTO `eb_user_task_finish` (task_id, uid, status, add_time) VALUES (1, #{idx}, 1, 1588552526);
    INSERT INTO `eb_user_task_finish` (task_id, uid, status, add_time) VALUES (2, #{idx}, 1, 1588552526);
  " if level > 1
  sql += "
    INSERT INTO `eb_user_task_finish` (task_id, uid, status, add_time) VALUES (3, #{idx}, 1, 1588552526);
    INSERT INTO `eb_user_task_finish` (task_id, uid, status, add_time) VALUES (4, #{idx}, 1, 1588552526);
  " if level > 1
  sql += "
    INSERT INTO `eb_user_task_finish` (task_id, uid, status, add_time) VALUES (5, #{idx}, 1, 1588552526);
    INSERT INTO `eb_user_task_finish` (task_id, uid, status, add_time) VALUES (6, #{idx}, 1, 1588552526);
  " if level > 2
  sql += "
    INSERT INTO `eb_user_task_finish` (task_id, uid, status, add_time) VALUES (7, #{idx}, 1, 1588552526);
    INSERT INTO `eb_user_task_finish` (task_id, uid, status, add_time) VALUES (8, #{idx}, 1, 1588552526);
  " if level > 3
  sql += "
    INSERT INTO `eb_user_task_finish` (task_id, uid, status, add_time) VALUES (9, #{idx}, 1, 1588552526);
    INSERT INTO `eb_user_task_finish` (task_id, uid, status, add_time) VALUES (10, #{idx}, 1, 1588552526);
  " if level > 4
  sql += "
    INSERT INTO `eb_user_task_finish` (task_id, uid, status, add_time) VALUES (11, #{idx}, 1, 1588552526);
    INSERT INTO `eb_user_task_finish` (task_id, uid, status, add_time) VALUES (12, #{idx}, 1, 1588552526);
  " if level > 5
  
  print('.')
  sql += "\n"
  return sql

end

def gen_sql_cmd users

  sql = "
    delete from crmeb.eb_user where 1=1;
    delete from crmeb.eb_wechat_user where 1=1;
    delete from crmeb.eb_user_level where 1=1;
    delete from crmeb.eb_user_task_finish where 1=1;
    BEGIN;
  "

  idx = 1
  users.each do |user|

    if user['openid'] != ''
      sql += gen_user_sql(user, idx)
      idx += 1
    end

  end
  sql += "COMMIT;"

  fn = "export-users.sql"
  File.open(fn,"w:UTF-8") { |f| f.write sql }
  
  puts ("done #{users.size}")
  return sql
  
end

puts "reading all recs from pospal..."
users = read_pospal_users
fields = ['uid', 'number', 'name', 'phone', 'openid', 'unionid', 'avatar', 'discount', 'raw_data', 'points', 'discount', 'balance', 'address', 'created']

puts "writing excel file..."
save_to_excel fields, users, './export/pospal-users-all.xls'

puts "generating sql file..."
sql = gen_sql_cmd users
