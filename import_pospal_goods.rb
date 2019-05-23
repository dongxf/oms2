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
xls_file=".\\auto_import\\pospal_goods.xls"

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
    book = Spreadsheet.open xls_file
    sheet1 = book.worksheet 0
    line_idx = 0
    sheet1.each do |row|
        line_idx += 1
        next if line_idx == 1
        code = row[2]
        descrp = row[26]
        descrp = '' if descrp.nil?  #to prevent bugs caused by nil != nil when compring database record with excel data
        #will remove all links in description here

        if oNames[code].nil?
            puts "insert #{row[2]} #{row[0]}"
            sqlu = "insert into ogoods.pospal_goods( 
                        name,catalog,code,size,unit,
                        balance,purchase_price,sale_price,gross_profit,bulk_price,member_price,
                        member_discount, points, max_stock,minimal_stock,
                        brand,supplier,manufacture_date,baozhiqi_date,py_code,huo_number,
                        producer_memo,security_memo,keep_memo,scale_code,
                        status,description
                    ) values( 
                        '#{row[0]}','#{row[1]}','#{row[2]}','#{row[3]}','#{row[4]}',
                        #{row[5]},#{row[6]},#{row[7]},'#{row[8]}',#{row[9]},#{row[10]},
                        '#{row[11]}','#{row[12]}','#{row[13]}','#{row[14]}',
                        '#{row[15]}','#{row[16]}','#{row[17]}','#{row[18]}','#{row[19]}','#{row[20]}',
                        '#{row[21]}','#{row[22]}','#{row[23]}','#{row[24]}',
                        '#{row[25]}','#{descrp}'
                    );"
            resu = rds.query(sqlu)
        else
           #sqlu = "update psi.t_inventory_detail set balance_count=#{sprintf('%.8f', b_count)}, balance_money=#{sprintf('%.8f', b_money)}, balance_price=#{sprintf('%.8f', b_price)}, out_money=#{sprintf('%.8f', out_money)}, out_price=#{sprintf('%.3f', out_price)}, fixed='fixed' where id='#{inv_detail_id}'"
           if overwrite_mode || oNames[code]!= row[0] || oPrices[code]!= row[7] || oDescription[code]!= descrp
                #puts "update #{row[2]} #{row[0]}"
                sqlu = "update ogoods.pospal_goods set
                    name='#{row[0]}',catalog='#{row[1]}',code='#{row[2]}',size='#{row[3]}',unit='#{row[4]}',
                    balance=#{row[5]},purchase_price=#{row[6]},sale_price=#{row[7]},gross_profit='#{row[8]}',bulk_price=#{row[9]},member_price=#{row[10]},
                    member_discount='#{row[11]}',points='#{row[12]}',max_stock='#{row[13]}',minimal_stock='#{row[14]}',brand='#{row[15]}'
                    ,supplier='#{row[16]}',manufacture_date='#{row[17]}',baozhiqi_date='#{row[18]}',py_code='#{row[19]}',huo_number='#{row[20]}',
                    producer_memo='#{row[21]}',security_memo='#{row[22]}',keep_memo='#{row[23]}',scale_code='#{row[24]}',
                    status='#{row[25]}',description='#{descrp}'
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

#从ogoodsDB中按照分类目录和商品编号排序，导出所有库存不为零的商品，用于盘点
Spreadsheet.client_encoding="utf-8"
book=Spreadsheet::Workbook.new
sheet1=book.create_worksheet :name => "sheet1"
col_names= ['名称（必填）','分类（必填）','条码','规格','主单位','库存量（必填）','进货价（必填）','销售价（必填）','批发价','会员价','会员折扣','积分商品','库存上限','库存下限','品牌','供货商','生产日期','保质期','拼音码','货号','称编码','自定义1','自定义2','自定义3','商品状态','商品描述']
col_index=0
col_names.each do |cname|
    sheet1.row(0)[col_index]=cname
    col_index += 1
end
li = 0
sql1 = 'select * from ogoods.pospal_goods where balance>0 order by catalog desc, code'
res1 = rds.query(sql1)
res1.each do |r|
    next if r['catalog']=='系统保留' || r['catalog']=='补拍运费' || r['catalog']=='增值服务'
    li += 1
    sheet1.row(li)[0]=r['name']
    sheet1.row(li)[1]=r['catalog']
    sheet1.row(li)[2]=r['code']
    sheet1.row(li)[3]=r['size']
    sheet1.row(li)[4]=r['unit']
    sheet1.row(li)[5]=r['balance']
    sheet1.row(li)[6]=r['purchase_price']
    sheet1.row(li)[7]=r['sale_price']
    sheet1.row(li)[8]=r['bulk_price']
    sheet1.row(li)[9]=r['member_price']
    sheet1.row(li)[10]=r['member_discount']
    sheet1.row(li)[11]=r['points']
    sheet1.row(li)[12]=r['max_stock']
    sheet1.row(li)[13]=r['minimal_stock']
    sheet1.row(li)[14]=r['brand']
    sheet1.row(li)[15]=r['supplier']
    sheet1.row(li)[16]=r['manufacture_date']
    sheet1.row(li)[17]=r['baozhiqi_date']
    sheet1.row(li)[18]=r['py_code']
    sheet1.row(li)[19]=r['huo_number']
    sheet1.row(li)[20]=r['scale_code']
    sheet1.row(li)[21]=r['producer_memo']
    sheet1.row(li)[22]=r['security_memo']
    sheet1.row(li)[23]=r['keep_memo']
    sheet1.row(li)[24]=r['status']
    sheet1.row(li)[25]=r['description']
end

rday =Date.today.strftime('%Y-%m-%d')
rtime=Time.now.strftime("%H%M%S")
fn_name = ".\\auto_import\\" + rday + "-stock-" + rtime + ".xls"
book.write fn_name

