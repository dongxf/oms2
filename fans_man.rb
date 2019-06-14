#encoding: utf-8

=begin
完成以下步骤
1) 重置所有用户订阅状态为no
2) 根据最新的wechat_fans.xls重新写yes标志( 发送工具获取全部粉丝信息，导出EXCEL，另存为XLS)
3) 读sub_data.xls更新no标志(用金数据导出订阅设置，另存为XLS)
4) 将所有空的名字和空头像设一个默认值
5）将所有可推送列表写为push_list.xls
6) 如果是-e,只负责导出即可: export_only
7) 如果是-i,只负责导入取消订阅数据: unsub.txt
=end

require 'mysql2'
require 'awesome_print'
require 'spreadsheet'

def step5
    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'], :encoding => 'utf8mb4' )
    puts "step5: generate push_list.xls..."
    Spreadsheet.client_encoding="utf-8"
    book=Spreadsheet::Workbook.new
    #创建工作表
    sheet1=book.create_worksheet :name => "sheet1"
    line_idx=0
    sheet1.row(line_idx)[0]='openid'
    sqlu="select openid from ogoods.wechat_fans where subscrib_status='yes'"
    res = rds.query sqlu
    res.each do |r|
        line_idx += 1
        sheet1.row(line_idx)[0]=r['openid']
    end
    fn_name =".\\auto_import\\push_list.xls"
    book.write fn_name
    puts "done. #{line_idx}"
end

def step3
    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'], :encoding => 'utf8mb4' )
    puts "step 3: set unscribed according to sub_data..."
    xls_file=".\\auto_import\\sub_data.xls"
    Spreadsheet.client_encoding='UTF-8'
    book = Spreadsheet.open xls_file
    sheet1 = book.worksheet 0
    line_idx = 0
    sheet1.each do |row|
        line_idx += 1
        next if line_idx == 1
        openid = row[9]
        subscrib_status = row[1]=='不需要' ? 'no':'yes'
        if subscrib_status == 'no'
            sqlu = "update ogoods.wechat_fans set subscrib_status='#{subscrib_status}' where openid = '#{openid}'"
            resu = rds.query(sqlu)
            print "updating wechat fans #{line_idx}\r"
        end
    end
    puts "done. #{line_idx}"
end

def import_unsub_data
    openids = IO.readlines(".\\auto_import\\unsub.txt")
    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'], :encoding => 'utf8mb4' )
    puts "import unsub.txt..."
    openids.each do |openid|
            oid=openid.gsub('"','').gsub("\n","")
            sqlu = "update ogoods.wechat_fans set subscrib_status='no' where openid='#{oid}'"
            res = rds.query(sqlu)
            p sqlu
    end
    puts "done."
end

export_only = false
if ARGV[1] == '-e' || ARGV[0] == '-e'
    step5
    exit
end

if ARGV[1] == '-i' || ARGV[0] == '-i'
    import_unsub_data #update unfollowed fans
    step3 #update unsubscribed fans
    step5
    exit
end


#ATTENTION: wechat_fans table muse be coded in UTF8MB4 to save emojii chars
rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'], :encoding => 'utf8mb4' )

begin

    xls_file=".\\auto_import\\wechat_fans.xls"
    Spreadsheet.client_encoding='UTF-8'

    # step 1
    puts "step 1: overwrite mode: all rec reset to unsubscribed..."
    sqlu = "update ogoods.wechat_fans set subscrib_status='no' where 1=1"
    res = rds.query(sqlu)
    puts "done."
    
    puts "step2: overwrite wechat_fans using new exporte wechat_fans xls..."
    book = Spreadsheet.open xls_file
    sheet1 = book.worksheet 0
    line_idx = 0
    sheet1.each do |row|

        line_idx += 1
        next if line_idx == 1 #跳过第一行表头

        openid = row[0]
        escaped_nick_name = row[2].gsub("'","''") #用于SQL语句中的转义

        sqlu = "insert into ogoods.wechat_fans(
                    openid,avatar,nick_name,gender,location,subscription_time,subscrib_status
                )values(
                    '#{row[0]}','#{row[1]}','#{escaped_nick_name}','#{row[3]}','#{row[4]}', '#{row[5]}', 'yes' 
                )on duplicate key update subscrib_status = 'yes'"
        print "updating wechat fans #{line_idx}\r"
        resu = rds.query(sqlu)
    end
    p "done. #{line_idx}"

    step3

    puts "step4: update null name or null avatar"
    sqlu = " update ogoods.wechat_fans set nick_name='somebody' where nick_name is null or nick_name = ''"
    rds.query sqlu
    sqlu = " update ogoods.wechat_fans set avatar='http://thirdwx.qlogo.cn/mmopen/ajNVdqHZLLBfGFYt68LDRsF4YS0PYdJ30licWyfwlEmokFbNKRfdLTurn4hJmQM5ibm98zia0tVV9tAxaNtEfibD2g/132' where avatar is null or avatar = ''"
    rds.query sqlu
    puts "done."

    step5

rescue => e
    puts ">>>ERROR: #{e}"
end
