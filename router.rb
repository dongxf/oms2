#encoding 'utf-8'
#This file provide an common method to decide with route should be allocated to specified order
#In the end this should be done in database
require 'time'
require 'spreadsheet'

def get_short_addr order
    return '番禺大石朝阳东路425号锦绣银湾3街17号' if order['contactTel']=='13711382291' #泳远恭子'
    return '番禺汉溪大道锦绣香江山水园8栋1102' if order['contactTel']=='13682263085' #皮女士'
    fat_addr = order['contactAddress'].gsub(" ","")
    fat_addr = order['contactAddress'].gsub("\n","") #如果地址中有换行，parse时会出错
    fat_addr.gsub!('10座1101，梁幼花，15768099989','10座1101')
    fat_addr.gsub!('侨朕中学（雅居乐旁，地铁员岗站A出口往西100米）','侨朕中学')
    fat_addr.gsub!('五幢（入口在西城花园九街五座斜对面）602','五幢602')
    return fat_addr.gsub("\u5E7F\u4E1C\u7701\u5E7F\u5DDE\u5E02","\u5E7F\u5DDE")
end

def get_short_no order
    return order['orderNo'][0..order['orderNo'].length-4]
end

def get_short_name order
    fat_name = order['contactName'].gsub(" ","")
    return fat_name.gsub("\u5E7F\u4E1C\u7701\u5E7F\u5DDE\u5E02","\u5E7F\u5DDE")
end

def get_short_remark order
    omk = order['orderRemark'] ? order['orderRemark'].gsub('配送','').gsub(';','') : ''
    return ' :' + omk if omk != ''
    return omk
end

def get_batch_mark order
    order_time = Time.parse order['orderDateTime']
    batch2_start = Time.parse order_time.strftime('%Y-%m-%d') + ' 09:00:00' 
    batch2_end = Time.parse order_time.strftime('%Y-%m-%d') + ' 15:00:00' 
    return order_time > batch2_start && order_time <= batch2_end ? '#' : ' '
end

def get_noti order

    return '' if order['state'] == 4
    return '| 已取消' if order['state'] == 3

    order_state={0=>'初创建',1=>'已同步',2=>'已发货',3=>'已取消',4=>'已完成'}[order['state']]
    order_state="未定义" if order_state.nil?
    pay_method={'Cash'=>'现金','CustomerBalance'=>'余额','Wxpay'=>'微信','Alipay'=>'支付宝'}[order['payMethod']]
    delivery_type={0=>'自营',1=>'自助',2=>'自提',3=>'预约',4=>'三方'}[order['deliveryType']]
    pay_online={0=>'未用',1=>'通过'}[order['payOnLine']]
    opay_completed={0=>'未',1=>'已'}[order['isOnlinePaymentCompleted']]

    return " TT" if opay_completed=='已' && order_state=='未定义' #团购或问题单,通常是银豹收银端漏确认的订单
    return "> #{order_state} #{delivery_type}#{pay_method}支付#{pay_online}网付#{opay_completed}完成"

end

def decide_route order

    #    payment==0 && state == 4: X
    #    payment==0 && state != 4: X
    #    payment==1 && state == 3: X
    #    payment==1 && state == 4: normal
    #    payment==1 && state == other: T
    #    if payment == 1 & state ==3, it's normal order cancel by all refund
    return '[X]' if order['isOnlinePaymentCompleted']==0
    return '[X]' if order['state']==3 #其中会包含哪些全单退款的订单,将来这种订单应该要把它再单独标识出来
    return '[T]' if order['state']!=4 #nil, 1, 2 团购或待确认订单,或者奇怪的已取消已付款订单
    #pay==1 && state==4 goes below

    case get_zone_code(order)
    when 'ZT' 
        return '[Z]'
    when 'ZB', 'ZPP' 
        addr = get_short_addr order
        [ '清华坊', '华碧','华南碧桂园', '欧泊', '红郡' , '华南新城' , '雅居乐', '侨联中学' , '侨朕中学', '锦绣香江' , '星河湾' , '奥园城市天地', '南村时代倾城', '星汇文宇', '大学城', '大学小筑', '谷围新村', '小谷围街道', '深井村', '亚运城', '长洲街道', '兴亚二路' , '长洲岛' ].each do |w| 
            return '[G]' if addr.include? w 
        end
        return '[P]'
    when 'ZPG' 
        return '[G]'
    when 'KD1', 'KD2', 'SW' 
        return '[K]'
    else 
        return '[K]'
    end
 
end

def save_line_excel line_name, line_items
    #设置表格的编码为utf-8
    Spreadsheet.client_encoding="utf-8"
    #创建表格对象
    book=Spreadsheet::Workbook.new
    #创建工作表
    sheet1=book.create_worksheet :name => "sheet1"
    #col_names=['发货人姓名(必填)','发货人电话(必填)','发件人地址(必填)','收件人姓名(必填)','收件人电话(必填)','收件人地址(必填)','品名(必填)','付款方式(默认寄付)','内件数量','货物价值（选填）','备注（选填）','物流编号（选填）','代收费用（选填）'] #承诺达
    col_names=['序号','订单号','运单号','子单号','签回单号','寄方备注','寄方公司','寄方姓名','寄方联系方式','寄方地址','收方公司','收方姓名','收方联系方式','收方地址','商品名称','商品编码','商品数量','商品单价/元','商品货号','商品属性','包裹件数','业务类型','付款方式','月结卡号','包裹重量/KG','代收金额','代收卡号','保价金额','是否签回单','派送日期','派送时段','是否自取','是否保单配送','是否票据专送','是否易碎宝','易碎宝服务费/元','是否口令签收','标准化包装（元）','个性化包装（元）','其它费用（元）','超长超重服务费','是否双人派送','长(cm)','宽(cm)','高(cm)','扩展字段1','扩展字段2','扩展字段3','扩展字段4','扩展字段5','温区','签单返还范本','保鲜服务','WOW基础','WOW尊享','是否到付优惠','优惠月结卡号'] #顺丰标准

    sheet1.row(0)[0]=Time.now.to_s
    col_index=0
    col_names.each do |cname|
        sheet1.row(1)[col_index]=cname
        col_index += 1
    end

    line_index = 1
    line_items.each do |key, item_cells|
            col_index=0
            item_cells.each do |cell|
                sheet1.row(line_index+1)[col_index]=cell
                col_index += 1
            end
            line_index += 1
    end
    rday =Date.today.strftime('%Y-%m-%d')
    rtime=Time.now.strftime("%H%M%S")
    fn_name = ".\\incoming\\" + rday + "-summary-" + line_name + '-' + rtime + ".xls"
    book.write fn_name
end

def get_plain_text order

    content = ""
    if order['state']!= 4
      order_state={0=>'初创建',1=>'已同步',2=>'已发货',3=>'已取消',4=>'已完成'}[order['state']]
      pay_method={'Cash'=>'现金','CustomerBalance'=>'余额','Wxpay'=>'微信','Alipay'=>'支付宝'}[order['payMethod']]
      delivery_type={0=>'自营',1=>'自助',2=>'自提',3=>'预约',4=>'三方'}[order['deliveryType']]
      pay_online={0=>'未用',1=>'通过'}[order['payOnLine']]
      opay_completed={0=>'还未',1=>'已经'}[order['isOnlinePaymentCompleted']]
      if order['isOnlinePaymentCompleted']==1 && order['state'].nil?
        #团购订单不增加备注
        content += ""
      else
        content += "> 状态#{order_state.nil? ? '未知' : order_state} #{pay_method}支付 #{pay_online}网付 #{opay_completed}完成 #{delivery_type}\n"
      end
    end

    fat_addr = order['contactAddress'].gsub(" ","")
    slim_addr=fat_addr.gsub("\u5E7F\u4E1C\u7701\u5E7F\u5DDE\u5E02","\u5E7F\u5DDE")
    line_mark = decide_route order
    zone_code = get_zone_code order
    odrmk = order['orderRemark'] ? order['orderRemark'].gsub('配送','') : ''

    #add header twice
    #全角空格字符 (　) (_) (﹏)
    content ="#{line_mark} #{zone_code}　　　　　让健康和友善触手可及　　　　﹏ of 2 ﹏\n"

    # remove '104' from the tail
    content  += "#{get_short_no order}　　#{order['orderDateTime']}\n"

    content += "#{slim_addr}\n"
    content += "#{order['contactName']}    #{order['contactTel']}\n"
    if odrmk != ''
      content += "> #{odrmk}   -----\n"
    else
      content  += "　　　　-　　　　　-　　　　　-　　　　　-　　　　-　　　　\n"
    end

    content += "#{get_short_no order}　　#{order['customerNumber']}　　　　　﹏ of 2 ﹏\n"

    content += "#{slim_addr}\n"
    content += "#{order['contactName']}    #{order['contactTel']}\n"
    if odrmk != ''
      content += "> #{odrmk}   ------\n"
    end

    if order['state']!= 4 && order['state']!= 3
      if order['isOnlinePaymentCompleted']==1 && order['state'].nil?
        content += ">>>>>>>>> 团购订单 <<<<<<<<<\n"
      else
        content += ">>>>>>>>> 警告：非常态，单独处理 s#{order['state']} p#{order['isOnLinePaymentCompleted']}<<<<<<<<<\n"
      end
    else
      content += "--------------------------------------------------<<<<<<<<<\n"
    end
    content += " 数量     商品名及规格\n"
    items = order['items']
    items.each do |item|
        if item['productQuantity']>1 
            bold = " *"
            bold = "**" if item['productQuantity']>2
            qty = bold + sprintf("%d",item['productQuantity'])
        else
            qty = "  " + sprintf("%d",item['productQuantity'])
        end
        content += "#{qty} [   ] #{item['productName']}\n"
    end
    content += "\n"

    #add footer
    content += "--------------------------------------------------------------------\n"
    content += "END_OF_PICKUP_LIST"

    return content

end

def get_zone_code order

  addr = get_short_addr order
  puts "---#{addr}---" if addr.include? '钟村街道天湖居'

  #到店自提：ZT
  [ '到店自提', '汉溪村', 'Self Pickup'].each { |w| return 'ZT' if addr.include? w }

  #正常会用佛山市顺德区
  return 'ZPP' if addr.include?('顺德') && addr.include?('碧桂园')

  #番禺区&大学城: ZPP ZPG ZB KD1
  if addr.include?('番禺') || addr.include?('黄埔')

    #用于缺失小区信息的地址，例如 广州市钟村街道天湖居
    ['钟村街道天湖居'].each { |w| return 'ZB' if addr.include? w }

    #宅配P: ZPP
    return 'ZPP' if addr.include?('雅居乐') && !addr.include?('南城')
    ['星汇文宇','丽江花园','洛浦街道', '百事佳花园', '洛溪南浦锦绣半岛', '丹山新村', '大学城', '前龙西路', '大学小筑', '谷围新村', '小谷围街道', '深井村', '亚运城', '长洲街道', '前锋村', '西城花园' , '兴亚二路' , '清华坊', '长洲岛', '东华花园','康城水郡','东湖洲花园'].each do |w| 
        return 'ZPP' if addr.include? w 
    end
    #宅配G: ZPG
    return 'ZPG' if addr.include?('星河湾半岛') || addr.include?('沙溪') || addr.include?('珠江花园')
    #周边小区: ZB
    [ '华碧','华南碧桂园', '欧泊', '红郡' , '华南新城' , '雅居乐', '侨联中学' , '侨朕中学','华南新村' , '锦绣香江' , '星河湾' , '祈福' , '金山谷' , '富豪山庄' ,'南奥','南国奥','汉溪村', '奥园城市天地', '南村时代倾城'].each do |w| 
        return 'ZB' if addr.include? w 
    end
    #其余: KD1
    return 'KD1'
  end


  #广州市：ZPG KD1 KD2
  if addr.include? '广州'
      #用于缺失分区信息的客户地址，例如'广州市金穗路'
      ['金穗路'].each { |w| return 'ZPG' if addr.include? w }
      ['祈福新村','祈福康怡居'].each { |w| return 'ZB' if addr.include? w }
      #例外: KD1
      ['龙洞', '从化','增城','天源路','机务段机山巷','东莞庄路','白云区','黄埔区','萝岗区'].each { |w| return 'KD1' if addr.include? w }
      #边远区域: KD2
      #['增城'].each { |w| return 'KD2' if addr.include? w }
      #正常: ZPG
      ['南沙','增城','天河区','海珠区','越秀区','荔湾区'].each { |w| return 'ZPG' if addr.include? w }
      #其余: KD1
      return 'KD1'
  end

  #东莞及深圳主要区域：KD1
  ['东莞','深圳','中山','珠海','佛山'].each { |w| return 'KD1' if addr.include? w }

  #其它广东省内: KD2
  ['惠州','江门','汕头','湛江','河源', '肇庆','潮州','清远','韶关','揭阳','阳江','云浮','茂名','梅州','汕尾'].each { |w| return 'KD2' if addr.include? w }

  #其余：SW
  return 'SW'

end
