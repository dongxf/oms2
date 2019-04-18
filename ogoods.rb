#encoding: utf-8

#this tool will synced pospal goods exported data into ogoods db
#user can drag exported file into goods_exported and run this tool manually or automatically by win_cron

require 'mysql2'
require 'awesome_print'
require 'spreadsheet'

rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])
oNames = {};
oPrices = {};
oDescription = {};
overwrite_mode = false
xls_file=".\\goods_exported\\商品资料.xls"

args = ''
ARGV.each { |arg| args+=arg }
xls_file=args if args!='' && args!='-f'
if args=='-f'
    overwrite_mode=true 
    puts 'force mode actived'
end

# get current name and price list from ogoods db
sql1 = 'select * from ogoods.pospal_goods'
res1 = rds.query(sql1)
res1.each do |tgr|
    code = tgr['code']
    name = tgr['name']
    sale_price = tgr['sale_price']
    description = tgr['description']
    oNames.store(code,name)
    oPrices.store(code,sale_price)
    oDescription.store(code,description)
end
#puts "goods before synced: #{oNames.size}"


=begin
if existed new excel data
    read it line by line
        for each line
            if code not existed in ogoods db hash then insert
            if code existed but name and sale_price changed, update it
    rename the file
=end
Spreadsheet.client_encoding='UTF-8'
begin
    #book = Spreadsheet.open ".\\goods_exported\\商品资料.xls"
    book = Spreadsheet.open xls_file
    sheet1 = book.worksheet 0
    line_idx = 0
    sheet1.each do |row|
        line_idx += 1
        next if line_idx == 1
        code = row[2]
        descrp = row[25]
        descrp = '' if descrp.nil?  #to prevent bugs caused by nil != nil when compring database record with excel data
        #will remove all links in description here

        if oNames[code].nil?
            puts "insert #{row[2]} #{row[0]}"
            sqlu = "insert into ogoods.pospal_goods( 
                        name,catalog,code,size,unit,
                        balance,purchase_price,sale_price,bulk_price,member_price,
                        member_discount, points, max_stock,minimal_stock,
                        brand,supplier,manufacture_date,baozhiqi_date,py_code,huo_number,
                        producer_memo,security_memo,keep_memo,scale_code,
                        status,description
                    ) values( 
                        '#{row[0]}','#{row[1]}','#{row[2]}','#{row[3]}','#{row[4]}',
                        #{row[5]},#{row[6]},#{row[7]},#{row[8]},#{row[9]},
                        '#{row[10]}','#{row[11]}','#{row[12]}','#{row[13]}',
                        '#{row[14]}','#{row[15]}','#{row[16]}','#{row[17]}','#{row[18]}','#{row[19]}',
                        '#{row[20]}','#{row[21]}','#{row[22]}','#{row[23]}',
                        '#{row[24]}','#{descrp}'
                    );"
            resu = rds.query(sqlu)
        else
           #sqlu = "update psi.t_inventory_detail set balance_count=#{sprintf('%.8f', b_count)}, balance_money=#{sprintf('%.8f', b_money)}, balance_price=#{sprintf('%.8f', b_price)}, out_money=#{sprintf('%.8f', out_money)}, out_price=#{sprintf('%.3f', out_price)}, fixed='fixed' where id='#{inv_detail_id}'"
           if overwrite_mode || oNames[code]!= row[0] || oPrices[code]!= row[7] || oDescription[code]!= descrp
                puts "update #{row[2]} #{row[0]}"
                sqlu = "update ogoods.pospal_goods set
                    name='#{row[0]}',catalog='#{row[1]}',code='#{row[2]}',size='#{row[3]}',unit='#{row[4]}',
                    balance=#{row[5]},purchase_price=#{row[6]},sale_price=#{row[7]},bulk_price=#{row[8]},member_price=#{row[9]},
                    member_discount='#{row[10]}',points='#{row[11]}',max_stock='#{row[12]}',minimal_stock='#{row[13]}',
                    brand='#{row[14]}',supplier='#{row[15]}',manufacture_date='#{row[16]}',baozhiqi_date='#{row[17]}',py_code='#{row[18]}',huo_number='#{row[19]}',
                    producer_memo='#{row[20]}',security_memo='#{row[21]}',keep_memo='#{row[22]}',scale_code='#{row[23]}',
                    status='#{row[24]}',description='#{descrp}'
                    where code = '#{row[2]}'
                "
                resu = rds.query(sqlu)
           end
        end
    end
    #puts "total record in data file: #{line_idx}"
rescue => e
    puts ">>>ERROR: #{e}"
end
