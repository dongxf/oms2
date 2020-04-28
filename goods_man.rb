#encoding: utf-8

#this tool will synced pospal goods exported data into ogoods db
#user can drag exported file into goods_exported and run this tool manually or automatically by win_cron

require 'mysql2'
require 'json'
require 'awesome_print'
require 'spreadsheet' #用于写xls文件
require 'simple-spreadsheet' #用于读取xlsx文件，spreadsheet gem读xlsx会报签名错误
require 'open-uri'
require 'nokogiri'

@rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])

overwrite_mode = false
#xls=".\\auto_import\\pospal_goods.xls"
xls=".\\export\\pospal-all.xlsx"
xls="export/pospal-all.xlsx"

args = ''
ARGV.each { |arg| args+=arg }
xls=args if args!='' && args!='-f'
if args=='-f'
    overwrite_mode=true 
end

def cleanOgoodsTable
    sqlu = 'delete from ogoods.pospal_goods where 1=1'
    puts "overwrite mode: #{sqlu}"
    @rds.query(sqlu)
end

def getPospalJson
    images = {}
    pospal_products=JSON.parse IO.readlines(".//export//pospal-products.json")[0]
    pospal_products.each do |product|
        name = product['productName']
        barcode = product['productBarcode']
        imageUrl = product['imageUrl']
        images.store(barcode,imageUrl)
    end
    return images
end

# get current name and price list from ogoods db
def getGoodsCodeHash
        codes = {};
        names = {};
        prices = {};
        images = {};
        descriptions = {};

        sql1 = 'select * from ogoods.pospal_goods'
        res1 = @rds.query(sql1)
        idx = 1
        res1.each do |tgr|
            code = tgr['code']
            codes.store(code,idx)
            names.store(code,tgr['name'])
            prices.store(code,tgr['sale_price'])
            descriptions.store(code,tgr['description'])
            images.store(code,tgr['img_url'])
			idx += 1
        end
        puts "goods before synced: #{names.size}"
        return {codes: codes, names: names, prices: prices, descriptions: descriptions, images: images}
end

def updateImgPage
    puts "update img_url & page in ogoods using json file"
    images = getPospalJson
    images.each do |code, url|
        url = 'https://oss.foodtrust.cn//8322720200425033706535.jpg' if url.nil?
        page = genPageContent code
        sqlu = "update ogoods.pospal_goods set img_url = '" + url + "' , page = '" + page + "' where code = '" + code + "'";
        begin
            resu = @rds.query(sqlu)
        rescue => e
            puts ">>>ERROR: #{e}"
            puts sqlu 
        end
        print "update image & page content for #{code}                \r"
    end
    puts "done"
end

#to let description can be line changed when using by cloud label printing
#line break when: 1. double blank used in Cornel; 2. there's 18 chars in line
def breakLines text
    result = ''
    line_index=0
    char_index=0
    while char_index < text.size
            line_index += 1
            if (char_index<text.size-1) && (text[char_index..char_index+1]) == '  '
                result += '<br>'
                char_index += 1
                line_index = 0
            else
                result += text[char_index] if text[char_index]
            end
            if line_index == 18
                line_index = 0
                result += '<br>'
            end
            char_index += 1
    end
    return result
end

def escp str
    # '\' can't be correctly processed yet, :(
    return str.gsub("'",%q(\\\'));
end


def updateOgoodsByExcel xlsx

        gtch = getGoodsCodeHash
        oNames = gtch[:names]
        oPrices = gtch[:prices]

        s = SimpleSpreadsheet::Workbook.read xlsx
        s.selected_sheet = s.sheets.first
        line_idx = 0
        s.first_row.upto(s.last_row) do |line|
            line_idx += 1
            next if line_idx == 1
            code = s.cell(line,3)
            descrp = s.cell(line,27)
            descrp = '' if descrp.nil?  #to prevent bugs caused by nil != nil when compring database record with excel data
            descrp = breakLines descrp
            descrp = escp descrp
            #will remove all links in description here

            sale_price = s.cell(line,7)
            bulk_price = s.cell(line,10)
            member_price = s.cell(line,11)

            bulk_price = sale_price if bulk_price == '' || bulk_price.nil?
            member_price = sale_price if member_price == '' || member_price.nil?

            if oNames[code].nil?
                sqlu = "insert into ogoods.pospal_goods( 
                            name,catalog,code,size,unit,
                            balance,purchase_price,sale_price,gross_profit,bulk_price,member_price,
                            member_discount, points, max_stock,minimal_stock,
                            brand,supplier,manufacture_date,baozhiqi_date,py_code,huo_number,
                            producer_memo,security_memo,keep_memo,scale_code,
                            status,description
                        ) values( 
                            '#{escp s.cell(line,1)}','#{s.cell(line,2)}','#{s.cell(line,3)}','#{s.cell(line,4)}','#{s.cell(line,5)}',
                            #{s.cell(line,6)},#{s.cell(line,7)},#{s.cell(line,8)},'#{s.cell(line,9)}',#{bulk_price},#{member_price},
                            '#{s.cell(line,12)}','#{s.cell(line,13)}','#{s.cell(line,14)}','#{s.cell(line,15)}',
                            '#{s.cell(line,16)}','#{s.cell(line,17)}','#{s.cell(line,18)}','#{s.cell(line,19)}','#{s.cell(line,20)}','#{s.cell(line,21)}',
                            '#{s.cell(line,22)}','#{s.cell(line,23)}','#{s.cell(line,24)}','#{s.cell(line,25)}',
                            '#{s.cell(line,26)}','#{descrp}'
                        );"
                begin
                    resu = @rds.query(sqlu)
                    print "insert #{s.cell(line,3)} #{s.cell(line,1)}\r"
                rescue => e
                    puts ">>>ERROR: #{e}"
                    puts sqlu
                    puts "#{s.cell(line,10)},#{s.cell(line,11)} #{sale_price} #{sale_price}"
                    puts "<<<"
                end
            else
                #if name / price not changed, skip update
                if oNames[code]!= s.cell(line,1) || oPrices[code]!= s.cell(line,8)

                    sqlu = "update ogoods.pospal_goods set
                        name='#{escp s.cell(line,1)}',catalog='#{s.cell(line,2)}',code='#{s.cell(line,3)}',size='#{s.cell(line,4)}',unit='#{s.cell(line,5)}',
                        balance=#{s.cell(line,6)},purchase_price=#{s.cell(line,7)},sale_price=#{s.cell(line,8)},gross_profit='#{s.cell(line,9)}',bulk_price=#{bulk_price},member_price=#{member_price},
                        member_discount='#{s.cell(line,12)}',points='#{s.cell(line,13)}',max_stock='#{s.cell(line,14)}',minimal_stock='#{s.cell(line,15)}',brand='#{s.cell(line,16)}'
                        ,supplier='#{s.cell(line,17)}',manufacture_date='#{s.cell(line,18)}',baozhiqi_date='#{s.cell(line,19)}',py_code='#{s.cell(line,20)}',huo_number='#{s.cell(line,21)}',
                        producer_memo='#{s.cell(line,22)}',security_memo='#{s.cell(line,23)}',keep_memo='#{s.cell(line,24)}',scale_code='#{s.cell(line,25)}',
                        status='#{s.cell(line,26)}',description='#{descrp}'
                        where code = '#{s.cell(line,3)}'
                    "
                    begin
                        resu = @rds.query(sqlu)
                        print "update #{s.cell(line,3)} #{s.cell(line,1)}\r"
                        #puts "updating #{code}: #{oNames[code]} vs #{s.cell(line,1)} || #{oPrices[code]} vs #{s.cell(line,8)}"
                    rescue => e
                        puts ">>>ERROR: #{e}"
                        puts sqlu
                        puts "#{s.cell(line,10)},#{s.cell(line,11)} #{sale_price} #{sale_price}"
                        puts "<<<"
                    end
               #else
                    #print "skip #{s.cell(line,3)} #{s.cell(line,1)}\r"
               end
            end
        end
        puts "\ndone. #{line_idx}"

end

#从ogoodsDB中按照分类目录和商品编号排序，导出所有库存不为零的商品，用于盘点
def exportNoneZeroProducts

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
    res1 = @rds.query(sql1)
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
    fn_name = ".\\auto_import\\stock\\" + rday + "-stock-" + rtime + ".xls"
    fn_name2 = ".\\export\\" + rday + "-target-" + rtime + ".xls"
    book.write fn_name

end

def overwriteOgoodsByExcel xlsx

        cleanOgoodsTable 

        s = SimpleSpreadsheet::Workbook.read xlsx
        s.selected_sheet = s.sheets.first
        line_idx = 0
        s.first_row.upto(s.last_row) do |line|
            line_idx += 1
            next if line_idx == 1
            code = s.cell(line,3)
            descrp = s.cell(line,27)
            descrp = '' if descrp.nil?  #to prevent bugs caused by nil != nil when compring database record with excel data
            descrp = breakLines descrp
            descrp = escp descrp
            #will remove all links in description here

            sale_price = s.cell(line,7)
            bulk_price = s.cell(line,10)
            member_price = s.cell(line,11)

            bulk_price = sale_price if bulk_price == '' || bulk_price.nil?
            member_price = sale_price if member_price == '' || member_price.nil?

            sqlu = "insert into ogoods.pospal_goods( 
                        name,catalog,code,size,unit,
                        balance,purchase_price,sale_price,gross_profit,bulk_price,member_price,
                        member_discount, points, max_stock,minimal_stock,
                        brand,supplier,manufacture_date,baozhiqi_date,py_code,huo_number,
                        producer_memo,security_memo,keep_memo,scale_code,
                        status,description,img_url,page
                    ) values( 
                        '#{escp s.cell(line,1)}','#{s.cell(line,2)}','#{s.cell(line,3)}','#{s.cell(line,4)}','#{s.cell(line,5)}',
                        #{s.cell(line,6)},#{s.cell(line,7)},#{s.cell(line,8)},'#{s.cell(line,9)}',#{bulk_price},#{member_price},
                        '#{s.cell(line,12)}','#{s.cell(line,13)}','#{s.cell(line,14)}','#{s.cell(line,15)}',
                        '#{s.cell(line,16)}','#{s.cell(line,17)}','#{s.cell(line,18)}','#{s.cell(line,19)}','#{s.cell(line,20)}','#{s.cell(line,21)}',
                        '#{s.cell(line,22)}','#{s.cell(line,23)}','#{s.cell(line,24)}','#{s.cell(line,25)}',
                        '#{s.cell(line,26)}','#{descrp}','https://oss.foodtrust.cn//8322720200425033706535.jpg',''
                    );"
            begin
                resu = @rds.query(sqlu)
                print "insert #{s.cell(line,3)} #{s.cell(line,1)}\r"
            rescue => e
                puts ">>>ERROR: #{e}"
                puts sqlu
                puts "#{s.cell(line,10)},#{s.cell(line,11)} #{sale_price} #{sale_price}"
                puts "<<<"
            end

        end
        puts "\ndone. #{line_idx}"

end

# pospal will only retrun some frame html code, real content is supposed to be grab by js
# 银豹的商品详情页是动态生产的，无法自动抓取，亲请自行打开一下链接查看，在后台复制替换
def getPospalPage code
    url = 'https://v3xg5-24.pospal.cn/m#/details/'+code
	html = open('https://v3xg5-24.pospal.cn/m#/details/'+code){|f| f.read}
	text = Nokogiri::HTML(html).text
	return text
end

def genPageContent code
    page='&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;抱歉，此商品详情内容尚未完成迁移，&lt;/p&gt;&lt;p&gt;产品管理人员正在快马加鞭复制黏贴。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;点击&lt;a href=&quot;https://shop.foodtrust.cn/m#/details/GOODS_CODE&quot; style=&quot;&quot; target=&quot;_self&quot; title=&quot;银豹系统商品详情页&quot;&gt;&lt;span style=&quot;color:#ff0000&quot;&gt;此处链接&lt;/span&gt;&lt;/a&gt;查看原系统商品描述&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;color:#88b04b&quot;&gt;温馨提示：右划屏幕或回退&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;br/&gt;&lt;/p&gt;&lt;hr/&gt;&lt;p&gt;后台产品管理者参考链接&lt;/p&gt;&lt;p&gt;&lt;a href=&quot;http://undefined&quot;&gt;https://shop.foodtrust.cn/m#/details/GOODS_CODE&lt;/a&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;'
    return page.gsub('GOODS_CODE',code)
end

def genCrmebProductSQL 

    inq = 'select * from ogoods.pospal_goods'
    res = @rds.query(inq)

    idx = 1
    sql = ""

    res.each do |r|
        code = r['code']
        #sql += "select * from crmeb.eb_store_product where id = #{idx} \n"
        sql += "insert into crmeb.eb_store_product values (
            #{idx},
            0,
            '#{@rds.escape r['img_url']}',
            '#{@rds.escape [r['img_url']].to_json}',
            '单规格商品名称',
            '简介一',
            '关键一',
            '',
            '2,3',
            99.00,
            0.00,
            199.00,
            0.00,
            '份一',
            0,
            0,
            1000,
            1,
            0,
            0,
            0,
            0,
            1588026008,
            0,
            0,
            0,
            99.00,
            19.00,
            0,
            NULL,
            0,
            0,
            22,
            0,
            '',
            '',
            '',
            1,
            0,
            '1,2,3' 
        );\n"
        idx += 1
        break if idx > 2
    end
    return sql
end

=begin  
#please download excel from pospal
update_goods = overwrite_mode ?  overwriteOgoodsByExcel(xls) : updateOgoodsByExcel(xls)

#please export json file using immigrate-products.rb
#update image & pages content link from pospal server
updateImgPage
=end

sql = genCrmebProductSQL
puts sql
