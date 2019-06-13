#encoding 'utf-8'
#This file provide an common method to decide with route should be allocated to specified order
#In the end this should be done in database
require 'time'
require 'spreadsheet'

def get_short_addr order
    return '番禺大石朝阳东路425号锦绣银湾3街17号' if order['contactTel']=='13711382291' #泳远恭子'
    fat_addr = order['contactAddress'].gsub(" ","")
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

def get_short_date order
    return order['orderDateTime'][0..order['orderDateTime'].length-10]
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

    return "| 团购+" if opay_completed=='已' && order_state=='未定义'
    return "> #{order_state} #{delivery_type}#{pay_method}支付#{pay_online}网付#{opay_completed}完成"

end

def decide_route order

    return '[P]' if order['contactTel']=='13711382291' #泳远恭子'

    #return '[T]' if order['state'].nil? && order['isOnlinePaymentCompleted']==1
    #return '[X]' if order['state'] != 4

    if order['state'].nil? && order['isOnlinePaymentCompleted']==1
      #团购或待确认订单
      return '[T]'
    else
      return '[X]' if order['state'] != 4
    end

    address = get_short_addr order

    return '[Z]' if address.include? '到店自提'
    return '[Z]' if address.include? '汉溪村'

    # if G line worload is too low , otherwise use P line
    return '[P]' if address.include? '欧泊' 
    return '[P]' if address.include? '红郡'
    return '[P]' if address.include? '华南新城'
    return '[P]' if address.include? '雅居乐'
    return '[P]' if address.include? '侨联中学'
    return '[P]' if address.include? '侨朕中学'
    return '[P]' if address.include? '华南新村'
    return '[P]' if address.include? '锦绣香江'
    return '[P]' if address.include?('星河湾') && !address.include?('半岛')

    return '[P]' if address.include? '丽江花园'
    return '[P]' if address.include? '洛浦街道'
    return '[P]' if address.include? '百事佳花园'
    return '[P]' if address.include? '洛溪南浦锦绣半岛'

    return '[Q]' if address.include? '祈福'
    return '[Q]' if address.include? '金山谷'
    return '[Q]' if address.include? '富豪山庄'

    return '[P]' if address.include? '大学城'
    return '[P]' if address.include? '前龙西路'
    return '[P]' if address.include? '大学小筑'
    return '[P]' if address.include? '谷围新村'
    return '[P]' if address.include? '深井村'
    return '[P]' if address.include? '亚运城'
    return '[P]' if address.include? '前锋村'
    return '[P]' if address.include? '西城花园'
    return '[P]' if address.include?('雅居乐') && !address.include?('南城')
    return '[P]' if address.include? '清华坊'
    return '[P]' if address.include?('南奥') || address.include?('南国奥')
    return '[P]' if address.include? '华南碧桂园'

    if address.include? '广州'
      #Insert any exception here
      #Exception in Area Name and Road name
      return '[G]' if address.include? '白云路'
      #Exception in PanYu
      return '[G]' if address.include? '星河湾半岛'
      return '[G]' if address.include? '沙溪'
      #Exception in YueXiu
      return '[K]' if address.include? '机务段机山巷'
      return '[K]' if address.include? '东莞庄路'

      #normal area
      return '[G]' if address.include? '天河区'
      return '[G]' if address.include? '海珠区'
      return '[G]' if address.include? '越秀区'
      return '[G]' if address.include? '荔湾区'
    end

    return '[K]'
 
end

def save_line_excel line_name, line_items
    #设置表格的编码为utf-8
    Spreadsheet.client_encoding="utf-8"
    #创建表格对象
    book=Spreadsheet::Workbook.new
    #创建工作表
    sheet1=book.create_worksheet :name => "sheet1"
    col_names=['发货人姓名(必填)','发货人电话(必填)','发件人地址(必填)','收件人姓名(必填)','收件人电话(必填)','收件人地址(必填)','品名(必填)','付款方式(默认寄付)','内件数量','货物价值（选填）','备注（选填）','物流编号（选填）','代收费用（选填）']

    col_index=0
    col_names.each do |cname|
        sheet1.row(0)[col_index]=cname
        col_index += 1
    end

    line_index = 0
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
    odrmk = order['orderRemark'] ? order['orderRemark'].gsub('配送','') : ''

    #add header twice
    #全角空格字符 (　) (_) (﹏)
    content ="#{line_mark}　　　　　　　　　每一天,更安心的选择　　　　﹏ of 2 ﹏\n"

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

    content += "#{order['contactAddress'].strip}\n"
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
      content += "--------------------------------------------------------------------\n"
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
    content += "缺货24小时内原路退款，售后请致电小蜜18998382701微信同号\n"
    content += "　　　　　　　　foodtrust.cn 买有机，到丰巢\n"

    return content

end

def get_zone_code order

  addr = get_short_addr order

  #到店自提
  return 'ZT' if addr.include? '到店自提'

  #附近小区
  if addr.include? '番禺'
        return 'GD' if addr.include? '星河湾半岛' #例外,区分于星河湾
        near_zones=[ '华碧','华南碧桂园', '欧泊', '红郡' , '华南新城' , '雅居乐', '侨联中学' , '侨朕中学','华南新村' , '锦绣香江' , '星河湾' , '祈福' , '金山谷' , '富豪山庄' ,'南奥','南国奥','汉溪村']
        near_zones.each do |zone|
            return 'ZB' if addr.include? zone
        end
  end

  #广东省内
  gd_cities = ['番禺','东莞','广州','花都','从化','增城','中山','深圳','惠州','江门','珠海','汕头','佛山','湛江','河源',
               '肇庆','潮州','清远','韶关','揭阳','阳江','云浮','茂名','梅州','汕尾']
  gd_cities.each do |city|
          return 'GD' if addr.include? city
  end

  #广东省外
  return 'SW'

end
