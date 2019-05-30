#encoding: utf-8

#this tool will read subscription data exported from jinshuju and set status for in wechat_fans database
#
#完整流程，发送工具获取全部粉丝信息，导出EXCEL，另存为XLS
#使用import_wechat_fans.rb将数据导入wechat_fans db
#用金数据导出订阅设置，另存为XLS
#使用sub_man将数据导入wechat_fans db
#SELECT * FROM `wechat_fans` where subscrib_status is null or subscrib_status = 'yes'
#注意在提供给发送工具之前，需要手工在数据库中将nick和avatar为空的数据重置
#结果存为XLSX，用发送工具读入即可
#
#
require 'mysql2'
require 'awesome_print'
require 'spreadsheet'

#ATTENTION: wechat_fans table muse be coded in UTF8MB4 to save emojii chars
rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'], :encoding => 'utf8mb4' )
wNickNames = {}
overwrite_mode = false
xls_file=".\\auto_import\\sub_data.xls"

args = ''
ARGV.each { |arg| args+=arg }
xls_file=args if args!='' && args!='-f'
if args=='-f'
    overwrite_mode=true 
    puts 'force mode actived'
end

# get current fans list from ogoods db
sql1 = 'select * from ogoods.wechat_fans'
res1 = rds.query(sql1)
res1.each do |tgr|
    openid = tgr['openid']
    nick_name = tgr['nick_name']
    wNickNames.store(openid,nick_name)
end
#puts "fans before synced: #{wNickNames.size}"


Spreadsheet.client_encoding='UTF-8'
begin
    book = Spreadsheet.open xls_file
    sheet1 = book.worksheet 0
    line_idx = 0
    sheet1.each do |row|
        line_idx += 1
        next if line_idx == 1
        openid = row[9]
        escaped_nick_name = row[5].gsub("'","''") #用于SQL语句中的转义
        #will remove all links in description here

        if wNickNames[openid].nil?
            #如果openid不存在于数据库
            puts "insert #{escaped_nick_name} into wechat_fans db"
            sqlu = "insert into ogoods.wechat_fans( 
                        openid,avatar,nick_name,gender,location,subscription_time
                    ) values( 
                        '#{row[9]}','#{row[10]}','#{escaped_nick_name}','','', ''
                    );"
            resu = rds.query(sqlu)
        else
           #如果openid存在于数据库,根据设置更新允许推送消息的设置
                puts "update subscrib_status for #{wNickNames[openid]}"
                subscrib_status = row[1]=='不需要'? 'no':'yes'
                sqlu = "update ogoods.wechat_fans set
                    subscrib_status='#{subscrib_status}'
                    where openid = '#{openid}'
                "
                puts sqlu
                resu = rds.query(sqlu)
        end
    end
    puts "total record in data file: #{line_idx}"
rescue => e
    puts ">>>ERROR: #{e}"
end
