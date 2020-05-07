#encoding: utf-8

=begin

api tools used to 
import pospal exported excel to ogoods.pospal_goods
read image url from pospal api to enhance pospal_goods

=end

require 'mysql2'
require 'json'
require 'awesome_print'
require 'spreadsheet' #用于写xls文件
require 'simple-spreadsheet' #用于读取xlsx文件，spreadsheet gem读xlsx会报签名错误
require 'open-uri'
require 'nokogiri'
load 'pospal_api.rb'
load 'rds_api.rb'

def cleanOgoodsTable
    sqlu = 'delete from ogoods.pospal_goods where 1=1'
    puts "overwrite mode: #{sqlu}"
    @rds.query(sqlu)
end

def parseImageUrls
    images = {}
    pospal_products=JSON.parse IO.readlines("goods-images.json")[0]
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

#update img_url & page content
def updateGoodsAttributes
    puts "update img_url & page in ogoods using json file"
    images = parseImageUrls
    images.each do |code, url|
        url = 'https://oss.foodtrust.cn//8322720200425033706535.jpg' if url.nil?
        page = genPageContent code #getPospalPage code not work yet
        sqlu = "update ogoods.pospal_goods set img_url = '" + url + "' , page = '" + page + "' where code = '" + code + "'";
        begin
            resu = @rds.query(sqlu)
        rescue => e
            puts ">>>ERROR: #{e}"
            puts sqlu 
        end
        print "update image & page content for #{code}                \r"
    end
    puts "\ndone. #{images.size}"
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
            #如果是新商品则创建
            if oNames[code].nil?
                print "creating #{s.cell(line,3)} #{s.cell(line,1)} in ogoods.popsal_goods...\r"
                insertSingleProduct s, line
            else
                #if name / price not changed, skip update
                print "updating #{s.cell(line,3)} #{s.cell(line,1)} in ogoods.pospal_goods...\r"
                updateSingleProduct s, line
            end
        end
        puts "\ndone. #{line_idx-1}"

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
            print "creating #{s.cell(line,3)} #{s.cell(line,1)} in ogoods.popsal_goods...\r"
            insertSingleProduct s, line
        end
        puts "\ndone. #{line_idx}"

end

def insertSingleProduct s, line

  descrp = s.cell(line,27)
  descrp = '' if descrp.nil?  #to prevent bugs caused by nil != nil when compring database record with excel data
  #descrp = breakLines descrp #used in open lable printing

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
          status,description,img_url,page,crmeb_pid
      ) values( 
          '#{@rds.escape s.cell(line,1)}','#{s.cell(line,2)}','#{s.cell(line,3)}','#{s.cell(line,4)}','#{s.cell(line,5)}',
          #{s.cell(line,6)},#{s.cell(line,7)},#{s.cell(line,8)},'#{s.cell(line,9)}',#{bulk_price},#{member_price},
          '#{s.cell(line,12)}','#{s.cell(line,13)}','#{s.cell(line,14)}','#{s.cell(line,15)}',
          '#{s.cell(line,16)}','#{s.cell(line,17)}','#{s.cell(line,18)}','#{s.cell(line,19)}','#{s.cell(line,20)}','#{s.cell(line,21)}',
          '#{s.cell(line,22)}','#{s.cell(line,23)}','#{s.cell(line,24)}','#{s.cell(line,25)}',
          '#{s.cell(line,26)}','#{@rds.escape descrp}','https://oss.foodtrust.cn//8322720200425033706535.jpg','',0
      );"

  queryRds sqlu

end

def updateSingleProduct s, line

  descrp = s.cell(line,27)
  descrp = '' if descrp.nil?  #to prevent bugs caused by nil != nil when compring database record with excel data
  #descrp = breakLines descrp #used in open lable printing

  sale_price = s.cell(line,7)
  bulk_price = s.cell(line,10)
  member_price = s.cell(line,11)

  bulk_price = sale_price if bulk_price == '' || bulk_price.nil?
  member_price = sale_price if member_price == '' || member_price.nil?

  #update should remain imgurl and crmeb_pid unchanged
  sqlu = "update ogoods.pospal_goods set
      name='#{@rds.escape s.cell(line,1)}',catalog='#{s.cell(line,2)}',code='#{s.cell(line,3)}',size='#{s.cell(line,4)}',unit='#{s.cell(line,5)}',
      balance=#{s.cell(line,6)},purchase_price=#{s.cell(line,7)},sale_price=#{s.cell(line,8)},gross_profit='#{s.cell(line,9)}',bulk_price=#{bulk_price},member_price=#{member_price},
      member_discount='#{s.cell(line,12)}',points='#{s.cell(line,13)}',max_stock='#{s.cell(line,14)}',minimal_stock='#{s.cell(line,15)}',brand='#{s.cell(line,16)}'
      ,supplier='#{s.cell(line,17)}',manufacture_date='#{s.cell(line,18)}',baozhiqi_date='#{s.cell(line,19)}',py_code='#{s.cell(line,20)}',huo_number='#{s.cell(line,21)}',
      producer_memo='#{s.cell(line,22)}',security_memo='#{s.cell(line,23)}',keep_memo='#{s.cell(line,24)}',scale_code='#{s.cell(line,25)}',
      status='#{s.cell(line,26)}',description='#{@rds.escape descrp}'
      where code = '#{s.cell(line,3)}';"

  queryRds sqlu

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
    #page='&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;抱歉，此商品详情内容尚未完成迁移，&lt;/p&gt;&lt;p&gt;产品管理人员正在快马加鞭复制黏贴。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;点击&lt;a href=&quot;https://v3xg5-24.pospal.cn/m#/details/GOODS_CODE&quot; style=&quot;&quot; target=&quot;_self&quot; title=&quot;银豹系统商品详情页&quot;&gt;&lt;span style=&quot;color:#ff0000&quot;&gt;此处链接&lt;/span&gt;&lt;/a&gt;查看原系统商品描述&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;color:#88b04b&quot;&gt;温馨提示：右划屏幕或回退&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;br/&gt;&lt;/p&gt;&lt;hr/&gt;&lt;p&gt;后台产品管理者参考链接&lt;/p&gt;&lt;p&gt;&lt;a href=&quot;http://undefined&quot;&gt;https://shop.foodtrust.cn/m#/details/GOODS_CODE&lt;/a&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;'
    page='&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;抱歉，此商品详情内容尚未完成迁移，&lt;/p&gt;&lt;p&gt;产品管理人员正在快马加鞭。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;点击&lt;a href=&quot;https://v3xg5-24.pospal.cn/m#/details/GOODS_CODE&quot; style=&quot;&quot; target=&quot;_self&quot; title=&quot;银豹系统商品详情页&quot;&gt;&lt;span style=&quot;color:#ff0000&quot;&gt;此处链接&lt;/span&gt;&lt;/a&gt;查看原系统商品描述&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;color:#88b04b&quot;&gt;温馨提示：右划屏幕或回退&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;br/&gt;&lt;/p&gt;&lt;hr/&gt;&lt;p&gt;后台产品管理者参考链接&lt;/p&gt;&lt;p&gt;&lt;a href=&quot;http://v3xg5-24.pospal.cn/m#/details/GOODS_CODE&quot;&gt;https://v3xg5-24.pospal.cn/m#/details/GOODS_CODE&lt;/a&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;'
    return page.gsub('GOODS_CODE',code)
end

def genCategories cat, idx, name

	list = {}
	list.store('个人护理', 21 )
	list.store('补拍运费', 2)
	list.store('产地直发', 3)
	list.store('时令蔬菜', 4)
	list.store('当季水果', 5)
	list.store('禽蛋鱼肉', 6)
	list.store('加工菜肴', 7)
	list.store('面点乳品', 8)
	list.store('粮油调料', 9)
	list.store('南北特产', 10)
	list.store('干果零食', 11)
	list.store('茶饮冲调', 12)
	list.store('更多好物', 13)
	list.store('环保日用', 21)
	list.store('环保福利', 23)
	list.store('母婴专区', 31)
	list.store('增值服务', 41)
	list.store('系统保留', 45)
	list.store('线下专用', 45)
	
	cats = "#{list[cat]}"
    cats += ',2' if name.include?('份额')
    cats += ',3' if name.include?('产地直发')
    cats += ',2' if name.include?('预售')

    return cats.split(',').uniq.join(',')
	
end

def createCrmebProducts
    sqls = []
    inq = 'select * from ogoods.pospal_goods'
    pid = 101 #id 1~100 reserved to system
    res = @rds.query(inq)
    res.each do |product|
      sqls += newCrmebProduct product, pid
      sqls += updatePidForGoods(pid, product['code'])
      pid += 1
    end
    return sqls
end

def updatePidForGoods pid, code
  return ["update ogoods.pospal_goods set crmeb_pid = #{pid} where code = '#{code}';\n"]
end

def newCrmebProduct r, idx

    # rds.query 不支持分号分开的sql语句
    sqls = []
    code = r['code']

=begin
    name,catalog,code,size,unit,
    balance,purchase_price,sale_price,gross_profit,bulk_price,member_price,
    member_discount, points, max_stock,minimal_stock,
    brand,supplier,manufacture_date,baozhiqi_date,py_code,huo_number,
    producer_memo,security_memo,keep_memo,scale_code,
    status,description,img_url,page,crmeb_pid
=end
    keywords = {brand: r['brand'], supplier: r['supplier'], producer: r['producer_memo'], security: r['security_memo'] ,conditions: r['keep_memo']}
		#line 9 对应目录，可以再优化 #关键字 应该可以用来做 生产者和保存条件的说明
        sqls += ["insert into crmeb.eb_store_product values (
            #{idx},
            0,
            '#{@rds.escape r['img_url']}',
            '#{@rds.escape [r['img_url']].to_json}',
            '#{@rds.escape r['name']}',
            '#{@rds.escape r['description']}',
            '#{@rds.escape keywords.to_json}',
            '#{r['code']}',
            '#{genCategories r['catalog'], idx, r['name']}',
            #{r['sale_price']},
            #{r['sale_price']},
            #{r['sale_price']},
            0.00,
            '#{r['unit']}',
            0,
            0,
            #{r['balance']},
            #{r['status']=='禁用' ? 0 : 1},
            0,
            0,
            0,
            0,
            1588026008,
            0,
            0,
            0,
            #{(r['sale_price'].to_f*0.9).to_i},
            #{r['purchase_price']},
            0,
            NULL,
            0,
            0,
            0,
            0,
            '',
            '',
            '',
            1,
            0,
            '1,2,3',
            '#{r['code']}'
        );\n"]

		sqls += ["INSERT INTO crmeb.eb_store_product_attr VALUES (
			#{idx},
			 '规格', 
			 '默认', 
			 0
		);\n"]

		#line 4 is sales history
		sqls += ["INSERT INTO crmeb.eb_store_product_attr_value
		VALUES(
				#{idx},
				'默认',
				#{r['balance']},
				0,
				#{r['sale_price']},
				'#{@rds.escape [r['img_url']].to_json}',
				LEFT(md5(uuid()),8),
				#{r['purchase_price']},
				'#{r['code']}',
				#{r['sale_price']},
				0.4,
				0.08,
				0.00,
				0.00,
				0,
				0,
				0 
		);\n"]
		
		genCategories(r['catalog'], idx, r['name']).split(',').each do |cat|
		sqls += ["INSERT INTO crmeb.eb_store_product_cate (product_id,cate_id,add_time) VALUES (
			#{idx},
			 #{cat}, 
			 1588026008
			 );\n"]
		end

		va = {}
		attr = [ {value: '规格', detailValue: '', attrHidden: '', detail: ['默认']} ]
		va.store(:attr, attr )
		
		value = [ { pic: r['img_url'],  price:	r['sale_price'], cost: r['purchase_price'], ot_price: r['sale_price'], stock: r['balance'], bar_code: r['code'], volume: "0.4", weight: "0.08", brokerage: 0, brokerage_two: 0, value: "规格", detail: {unit: "默认"} } ]
		va.store(:value, value)
		
		sqls += ["insert into crmeb.eb_store_product_attr_result values(
			#{idx},
			'#{@rds.escape(va.to_json)}',
			1588026008,
			0
		);\n"]
		
		sqls += ["insert into crmeb.eb_store_product_description values(
			#{idx},
			'#{@rds.escape r['page']}',
			0
		);\n"]

  return sqls

end

def getGoodsImages

    goodsImages=[]
    page_count = 0
    req={'postBackParameter'=>{}}

    begin
        page_count += 1 # to control loop times
        print "calling pospal api in #{page_count} time\r"

        res = pospal_api :queryProductImagePages, req
        recs = res['data']['result']
        recs.each { |rec| goodsImages += [rec] }

        actual_size = recs.size
        page_size = res['data']['pageSize']
        req = {'postBackParameter' => res['data']['postBackParameter'] }
        #ap res

        break if page_count >= 50 #used for saving api call times in coding pharse

    end while recs.size == page_size

    File.open( "goods-images-" + Time.now.strftime('%Y-%m-%d-%H%M%S') + ".json" ,"w:UTF-8") { |f| f.write goodsImages.to_json }
    File.open("goods-images.json","w:UTF-8") { |f| f.write goodsImages.to_json }

    puts "done. #{page_count} pages"
    return goodsImages

end 

def createDemoProducts

sql = "delete from crmeb.eb_store_product where 1=1;
delete from crmeb.eb_store_product_attr where 1=1;
delete from crmeb.eb_store_product_attr_value where 1=1;
delete from crmeb.eb_store_product_attr_result where 1=1;
delete from crmeb.eb_store_product_rule where 1=1;
delete from crmeb.eb_store_product_cate where 1=1;
delete from crmeb.eb_store_product_description where 1=1;
INSERT INTO `eb_store_product` VALUES (1, 0, 'https://oss.foodtrust.cn//372ad202004251014538878.jpg', '[\"https:\\/\\/oss.foodtrust.cn\\/\\/6db83202004250915485157.jpg\",\"https:\\/\\/oss.foodtrust.cn\\/\\/8322720200425033706535.jpg\"]', '测试产品甲-带视频', '[丰巢生态保证] 是什么让你笑起来？我的小命芽？', '{\"producer\":\"FOODTRUST\",\"brand\":\"FOODTRUST\"}', '', '45', 9.99, 0.00, 19.99, 0.00, '盒', 99, 0, 1000, 1, 0, 0, 0, 0, 1588336686, 0, 0, 0, 9.00, 1.00, 0, NULL, 0, 0, 0, 0, '', '', 'https://oss.foodtrust.cn/5raqo0ejskbjbkx2mer6s126gkpd6yu9.mp4', 1, 0, '1,2,3','0000000');
INSERT INTO `eb_store_product` VALUES (2, 0, 'https://cn.bing.com/th?id=OHR.BurgAltdahn_ZH-CN8281669977_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp', '[\"https:\\/\\/oss.foodtrust.cn\\/\\/6db83202004250915485157.jpg\",\"https:\\/\\/oss.foodtrust.cn\\/\\/8322720200425033706535.jpg\"]', '测试商品乙-多规格', '[中国有机认证] 若是你爱我，请宽恕我的欢喜', '{\"producer\":\"FOODTRUST\",\"brand\":\"FOODTRUST\"}', '', '45', 19.00, 0.00, 29.00, 0.00, '份', 98, 0, 4000, 1, 0, 0, 0, 0, 1588337246, 0, 0, 0, 29.00, 9.00, 0, NULL, 0, 0, 0, 0, '', '', '', 2, 1, '1,2,3','0000000');
INSERT INTO `eb_store_product_attr` VALUES (1, '规格', '默认', 0);
INSERT INTO `eb_store_product_attr` VALUES (2, '精细分割', '猪蹄,腰花,五花,梅头上', 0);
INSERT INTO `eb_store_product_attr_result` VALUES (1, '{\"attr\":[{\"value\":\"\\u89c4\\u683c\",\"detailValue\":\"\",\"attrHidden\":\"\",\"detail\":[\"\\u9ed8\\u8ba4\"]}],\"value\":[{\"pic\":\"https:\\/\\/oss.foodtrust.cn\\/\\/7739c202004250337006643.jpg\",\"price\":\"9.99\",\"cost\":\"1\",\"ot_price\":\"19.99\",\"stock\":\"1000\",\"bar_code\":\"646464\",\"volume\":\"0.01\",\"weight\":\"1\",\"brokerage\":0,\"brokerage_two\":0,\"value1\":\"\\u89c4\\u683c\",\"detail\":{\"\\u89c4\\u683c\":\"\\u9ed8\\u8ba4\"}}]}', 1588336686, 0);
INSERT INTO `eb_store_product_attr_result` VALUES (2, '{\"attr\":[{\"value\":\"\\u7cbe\\u7ec6\\u5206\\u5272\",\"detailValue\":\"\",\"attrHidden\":false,\"detail\":[\"\\u732a\\u8e44\",\"\\u8170\\u82b1\",\"\\u4e94\\u82b1\",\"\\u6885\\u5934\\u4e0a\"]}],\"value\":[{\"value1\":\"\\u732a\\u8e44\",\"detail\":{\"\\u7cbe\\u7ec6\\u5206\\u5272\":\"\\u732a\\u8e44\"},\"pic\":\"https:\\/\\/oss.foodtrust.cn\\/\\/d9975202004252022152724.png\",\"price\":\"49\",\"cost\":\"39\",\"ot_price\":\"59\",\"stock\":\"1000\",\"bar_code\":\"646460-1\",\"weight\":\"0.5\",\"volume\":\"0.01\",\"brokerage\":0,\"brokerage_two\":0},{\"value1\":\"\\u8170\\u82b1\",\"detail\":{\"\\u7cbe\\u7ec6\\u5206\\u5272\":\"\\u8170\\u82b1\"},\"pic\":\"https:\\/\\/oss.foodtrust.cn\\/\\/e0792202004252022151244.png\",\"price\":\"39\",\"cost\":\"29\",\"ot_price\":\"49\",\"stock\":\"1000\",\"bar_code\":\"646460-2\",\"weight\":\"0.5\",\"volume\":\"0.01\",\"brokerage\":0,\"brokerage_two\":0},{\"value1\":\"\\u4e94\\u82b1\",\"detail\":{\"\\u7cbe\\u7ec6\\u5206\\u5272\":\"\\u4e94\\u82b1\"},\"pic\":\"https:\\/\\/oss.foodtrust.cn\\/\\/668b4202004252022156019.png\",\"price\":\"29\",\"cost\":\"19\",\"ot_price\":\"39\",\"stock\":\"1000\",\"bar_code\":\"646460-3\",\"weight\":\"0.5\",\"volume\":\"0.01\",\"brokerage\":0,\"brokerage_two\":0},{\"value1\":\"\\u6885\\u5934\\u4e0a\",\"detail\":{\"\\u7cbe\\u7ec6\\u5206\\u5272\":\"\\u6885\\u5934\\u4e0a\"},\"pic\":\"https:\\/\\/oss.foodtrust.cn\\/\\/24282202004252022154243.png\",\"price\":\"19\",\"cost\":\"9\",\"ot_price\":\"29\",\"stock\":\"1000\",\"bar_code\":\"646460-4\",\"weight\":\"0.5\",\"volume\":\"0.01\",\"brokerage\":0,\"brokerage_two\":0}]}', 1588337247, 0);
INSERT INTO `eb_store_product_attr_value` VALUES (1, '默认', 1000, 0, 9.99, 'https://oss.foodtrust.cn//7739c202004250337006643.jpg', 'd21a1d77', 1.00, '646464', 19.99, 1.00, 0.01, 0.00, 0.00, 0, 0, 0);
INSERT INTO `eb_store_product_attr_value` VALUES (2, '猪蹄', 1000, 0, 49.00, 'https://oss.foodtrust.cn//d9975202004252022152724.png', '36d8fa8b', 39.00, '646460-1', 59.00, 0.50, 0.01, 0.00, 0.00, 0, 0, 0);
INSERT INTO `eb_store_product_attr_value` VALUES (2, '腰花', 1000, 0, 39.00, 'https://oss.foodtrust.cn//e0792202004252022151244.png', 'd9b33bbe', 29.00, '646460-2', 49.00, 0.50, 0.01, 0.00, 0.00, 0, 0, 0);
INSERT INTO `eb_store_product_attr_value` VALUES (2, '五花', 1000, 0, 29.00, 'https://oss.foodtrust.cn//668b4202004252022156019.png', '2814f7cc', 19.00, '646460-3', 39.00, 0.50, 0.01, 0.00, 0.00, 0, 0, 0);
INSERT INTO `eb_store_product_attr_value` VALUES (2, '梅头上', 1000, 0, 19.00, 'https://oss.foodtrust.cn//24282202004252022154243.png', '9221a81a', 9.00, '646460-4', 29.00, 0.50, 0.01, 0.00, 0.00, 0, 0, 0);
INSERT INTO `eb_store_product_cate` VALUES (1, 1, 45, 1588336686);
INSERT INTO `eb_store_product_cate` VALUES (2, 2, 45, 1588337246);
INSERT INTO `eb_store_product_description` VALUES (1, '&lt;p&gt;测试专用，&lt;span style=&quot;color:#ff0000&quot;&gt;不会实际发货&lt;/span&gt;，感谢理解！&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;https://oss.foodtrust.cn//849ba202004260851036015.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;文字在此&lt;/p&gt;&lt;div&gt;&lt;video style=&quot;width: 99%&quot; src=&quot;https://oss.foodtrust.cn/%E7%96%AB%E6%83%85%E4%B8%8B%E7%9A%84%E6%88%91%E4%BB%AC.mp4&quot; class=&quot;video-ue&quot; controls=&quot;controls&quot; width=&quot;100&quot;&gt;&lt;/video&gt;&lt;/div&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', 0);
INSERT INTO `eb_store_product_description` VALUES (2, '&lt;p&gt;测试专用，&lt;span style=&quot;color:#ff0000&quot;&gt;不会实际发货&lt;/span&gt;，感谢理解！&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;https://oss.foodtrust.cn//849ba202004260851036015.jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;文字在此&lt;/p&gt;&lt;div&gt;&lt;video style=&quot;width: 99%&quot; src=&quot;https://oss.foodtrust.cn/%E7%96%AB%E6%83%85%E4%B8%8B%E7%9A%84%E6%88%91%E4%BB%AC.mp4&quot; class=&quot;video-ue&quot; controls=&quot;controls&quot; width=&quot;100&quot;&gt;&lt;/video&gt;&lt;/div&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', 0);
INSERT INTO `eb_store_product_rule` VALUES (1, '二师兄的分割方式', '[{\"value\":\"\\u7cbe\\u7ec6\\u5206\\u5272\",\"detailValue\":\"\",\"attrHidden\":false,\"detail\":[\"\\u732a\\u8e44\",\"\\u8170\\u82b1\",\"\\u4e94\\u82b1\",\"\\u6885\\u5934\\u4e0a\"]}]');"

return sql.split("\n")
end
