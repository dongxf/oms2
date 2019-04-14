#encoding: utf-8
#this file shows all orders

require 'digest/md5'
require 'net/http'
require 'json'
require 'time'
require 'date'
require 'awesome_print'
require 'spreadsheet'

load 'router.rb'

#please set POSPAL_APPID and APPKEY in .bashrc
pospal_appid=ENV['POSPAL_APPID']
pospal_appkey=ENV['POSPAL_APPKEY']

today = Date.today
yesterday = today.prev_day
rday =Date.today.strftime('%Y-%m-%d')
rtime=Time.now.strftime("%H%M%S")
close_time = Time.parse today.strftime('%Y-%m-%d') + ' 15:10:00'
right_now = Time.now
s_time = yesterday.strftime('%Y-%m-%d') + ' 15:10:00'
e_time = today.strftime('%Y-%m-%d') + ' 15:09:59'
if ( right_now > close_time )
  s_time = today.strftime('%Y-%m-%d') + ' 15:10:00'
  e_time = today.strftime('%Y-%m-%d') + ' 23:59:59'
end
#s_time = today.strftime('%Y-%m-%d') + ' 00:00:00'
#e_time = today.strftime('%Y-%m-%d') + ' 23:59:59'

request_body = {
    'appId'=> pospal_appid,
    'startTime'=> s_time,
    'endTime'=> e_time
}

uri = URI('https://area24-win.pospal.cn:443/pospal-api2/openapi/v1/orderOpenApi/queryOrderPages')
res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
  req = Net::HTTP::Post.new(uri)
  req['User-Agent']= 'openApi'
  req['Content-Type']= 'application/json; charset=utf-8'
  req['accept-encoding']= 'gzip,deflate'
  req['time-stamp']= Time.now.getutc
  req['data-signature']= Digest::MD5.hexdigest(pospal_appkey + request_body.to_json)
  req.body = request_body.to_json
  http.request(req)
end

#ap res.body

orders = JSON.parse(res.body)['data']['result']
lines = ['[Z]','[C]','[G]','[Q]','[P]','[K]']
routes = {}
cnd_addrs = {}
lines.each do  |line|
  routes[line] = {}
end

#puts routes['Z']
#puts routes['C']

#col_names=['发货人姓名(必填)','发货人电话(必填)','发件人地址(必填)','收件人姓名(必填)','收件人电话(必填)','收件人地址(必填)','品名(必填)  付款方式(默认寄付)  内件数量   货物价值（选填）','备注（选填）','物流编号（选填）','代收费用（选填）']
index = -1
orders.each do |order|
    index +=1 
    next if order['state'] == 3
    fat_addr = order['contactAddress'].gsub(" ","")
    slim_addr=fat_addr.gsub("\u5E7F\u4E1C\u7701\u5E7F\u5DDE\u5E02","\u5E7F\u5DDE")
    fat_name = order['contactName'].gsub(" ","")
    slim_name = fat_name.gsub("\u5E7F\u4E1C\u7701\u5E7F\u5DDE\u5E02","\u5E7F\u5DDE")

    content = "orders[#{index}] #{order['orderDateTime']} ##{order['orderNo']} #{slim_addr} #{order['contactName']}  #{order['contactTel']}\n"
    addr = "#{slim_addr} \n  #{order['contactName']}  #{order['contactTel']} | #{order['orderRemark']} \n"
    if order['state']!= 4
      order_state={0=>'初创建',1=>'已同步',2=>'已发货',3=>'已取消',4=>'已完成'}[order['state']]
      pay_method={'Cash'=>'现金','CustomerBalance'=>'余额','Wxpay'=>'微信','Alipay'=>'支付宝'}[order['payMethod']]
      delivery_type={0=>'自营',1=>'自助',2=>'自提',3=>'预约',4=>'三方'}[order['deliveryType']]
      pay_online={0=>'未用',1=>'通过'}[order['payOnLine']]
      opay_completed={0=>'还未',1=>'已经'}[order['isOnlinePaymentCompleted']]
      content += "异常警告>>> 状态#{order_state.nil? ? '未知' : order_state} #{pay_method}支付 #{pay_online}网付 #{opay_completed}完成 #{delivery_type}\n"
      addr += " >>#{order_state.nil? ? '未知' : order_state} #{pay_method}支付 #{pay_online}网付 #{opay_completed}完成 #{delivery_type}\n"
    end

    line = decide_route addr
    routes[line].store(order['contactTel'],addr)
    if line == '[C]' || line == '[K]' || line == '[G]'
        ship_info=['黄冲','18148475667','广州市番禺区汉溪村汉溪路6号201',slim_name,order['contactTel'],slim_addr,'生鲜','寄付',"10","200",order['orderRemark']]
        #ap ship_info
        cnd_addrs.store(order['contactTel'],ship_info)
    end
    puts content
end
puts "Total: " + s_time + "--" + e_time + " >>" + " #{orders.count}"

#metrics.sort_by {|_key, value| value}.to_h
  # ==> {"siteb.com" => 9, "sitec.com" => 10, "sitea.com", 745}

lines.each do  |line|
  rdex = 1
  content = "\n\n\n>>>>>>>>>>  派线单 #{line} <<<<<<<<<<\n #{Time.now.to_s}\n\n"
  routes[line].sort_by{|_key, value| value}.to_h.each { |tel, addr|
    content += "#{rdex}) " + addr
    rdex +=1
  }
  fn_name = ".\\incoming\\" + rday + "-line-" + line[1] + "-" + rtime + ".txt"
  if routes[line].size!= 0 
    File.open(fn_name,"w:UTF-8") do |f|
        f.write content
    end
  end 
end


def toExcel line_items

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
    fn_name = ".\\incoming\\" + rday + "-CND-" + rtime + ".xls"
    book.write fn_name
end

toExcel cnd_addrs
