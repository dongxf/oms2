#encoding: utf-8

#this tool will synced wechat fans excel data goods exported data into wechat_fans db
#user can drag exported file into auto_import and run this tool manually or automatically by win_cron

require 'mysql2'
require 'awesome_print'
require 'spreadsheet'

#ATTENTION: wechat_fans table muse be coded in UTF8MB4 to save emojii chars
rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'], :encoding => 'utf8mb4' )
wNickNames = {}
overwrite_mode = false
xls_file=".\\auto_import\\wechat_fans.xls"

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
puts "fans before synced: #{wNickNames.size}"


Spreadsheet.client_encoding='UTF-8'
begin
    book = Spreadsheet.open xls_file
    sheet1 = book.worksheet 0
    line_idx = 0
    sheet1.each do |row|
        line_idx += 1
        next if line_idx == 1
        openid = row[0]
        escaped_nick_name = row[2].gsub("'","''") #用于SQL语句中的转义
        #will remove all links in description here

        if wNickNames[openid].nil?
            #如果openid不存在于数据库
            puts "insert #{row[0]} #{row[2]}"
            sqlu = "insert into ogoods.wechat_fans( 
                        openid,avatar,nick_name,gender,location,subscription_time
                    ) values( 
                        '#{row[0]}','#{row[1]}','#{escaped_nick_name}','#{row[3]}','#{row[4]}', '#{row[5]}'
                    );"
            resu = rds.query(sqlu)
        else
           #如果openid存在于数据库
           if overwrite_mode || wNickNames[openid]!= row[2]
                #如果昵称变化或者处于强制更新模式
                puts "update #{row[2]} #{row[0]} #{wNickNames[openid]}"
                sqlu = "update ogoods.wechat_fans set
                    openid='#{row[0]}',avatar='#{row[1]}',nick_name='#{escaped_nick_name}',gender='#{row[3]}',location='#{row[4]}', 
                    subscription_time='#{row[5]}'
                    where openid = '#{row[0]}'
                "
                resu = rds.query(sqlu)
           end
        end
    end
    #puts "total record in data file: #{line_idx}"
rescue => e
    puts ">>>ERROR: #{e}"
end


#新的fans列表里不存在的情况未来可以进一步处理，例如标记为已取消关注
