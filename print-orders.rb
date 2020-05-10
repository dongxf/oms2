#encoding: utf-8
=begin

Usage:      This ruby file will print crmeb orders for specific duration`
arguments:  ruby print-orders.rb [start_time backward_hours] [-s]'
Example:    ruby print-orders.rb 2019-07-09 08:00 24'
Comment:    无参数调用 ruby print-orders.rb, 相当于ruby order-man.rb current_time 24
            从现在倒推的24小时之内, 注意这个逻辑和order_man是有区别的，后者脑洞结构异常

=end

require 'time'
load 'rds_api.rb'

etime = ( ARGV[0] && ARGV[1] ) ? Time.parse("#{ARGV[0]} #{ARGV[1]}") : Time.now
bhours = ARGV[2] ? ARGV[2].to_i : 24
stime = etime - bhours*3600 + 1 #leave one second

def gen_pickup_text order

    statusHash = { -1 => '已退款', -2 => '退货成功', 0 => '待发货', 1 => '待收货', 2=> '已收货', 3=> '待评价' }
    refundHash = { 0 => '未退款', 1 => '申请退款中', 2 => '已退款' }

    #add header twice
    #全角空格字符 (　) (_) (﹏)
    order_time = Time.at(order['add_time']).strftime("%y%m%d %H:%M:%S")
    content ="[#{order['line']}]　　　　　　　让健康和友善触手可及　　　　1 of ﹏\n"
    content += "\n"
    content += "#{order['order_id']}　#{order_time}\n"
    content += order['shipping_type'] == 1 ? "#{order['user_address']}\n" : "补 拍 或 自 提 订 单\n"
    content += "#{order['real_name']}    #{order['user_phone']}\n"
    content += order['mark'].to_s == '' ?  "\n" : "> #{order['mark']}\n"
    content += "-　　　　-　　　　　-　　　　　-　　　　　-　2 of ﹏\n"
    content += order['remark'].to_s == '' ? "\n" : "< #{order['remark']}\n"
    content += "#{order['order_id']}　#{order_time}\n"
    content += "#{order['user_address']}\n"
    content += "#{order['real_name']}    #{order['user_phone']}\n"
    #content += "-　　　　-　　　　　-　　　　　-　　　　　-　　　　-\n"
    content += "----------------------------------------------------\n"
    orderStatus = statusHash[order['status']]
    refundStatus = refundHash[order['refund_status']]
    content += order['status'] == 0 && order['refund_status'] == 0 ? "\n" : ">>>>>>>>警告>>>>>>>>#{orderStatus}　#{refundStatus}\n"
    content += "数量　　商品名及规格\n"

    items = order['items']
    items.each do |item|
        bold = "　"
        bold = " *" if item['cart_info']['cart_num']>1
        bold = "**" if item['cart_info']['cart_num']>2
        qty = sprintf("%d",item['cart_info']['cart_num'])
        suk = item['cart_info']['productInfo']['attrInfo']['suk'] == '默认' ? '' : "##{item['cart_info']['productInfo']['attrInfo']['suk']}"
        content += "#{bold}#{qty} [　] #{item['cart_info']['productInfo']['store_name']}　#{suk}\n"
    end

    content += "-　　　　-　　　　　-　　　　　-　　　　　-　　　　-\n"
    content += "　　缺货商品原路退款，品质问题不满意无障碍退换\n"
    content += "　　　　每一天，更安心的选择　FOODTRUST\n"

=begin #standard line in pospal watcher
    content += "----------------------------------------------------\n"
    content += "-　　　　-　　　　　-　　　　　-　　　　　-　　　　-\n"
    content += "品质问不题题题题题题题题题题题题满意无障碍退换请联系\n"
    content += "123456789012345678901234567890123456789012\n"
=end

    return content

end

#根据地址分配配送线路
def allocate_line order
  return "K" #TBD
end

#数据库类型BigDecimal,在Hash中还是45.13的格式，但转为JSON字符串后它会被转为"0.4513e2"这样的字符串，等待用parseFloat来提取, 很讨厌，待解
def update_pickup_book_during stime, etime

  list = []
  res = @rds.query "select * from crmeb.eb_store_order where add_time >= #{stime.to_i} and add_time <= #{etime.to_i};" #using unix_timestamp
  res.each do |r|

    page = {}

    order = r
    #append cart itmes to records
    items = []
    its = queryRds "select * from crmeb.eb_store_order_cart_info where oid = #{order['id']};"
    its.each do |its| 
      items += [its] 
      #item中的cartinfo是用JSON String保存的，需要转换为正常对象
      cart_info = items.last['cart_info']
      items.last.store 'cart_info', JSON.parse(cart_info)
    end
    order.store "items", items

    #append line information to records
    line = allocate_line order
    order.store "line", "K"

    #update orders information to fc_pickup_book with generating plain text
    text = gen_pickup_text order

    queryRds "insert into crmeb.fc_pickup_book ( oid, uid, add_time, update_time, json, text ) values (
        #{order['id']}, #{order['uid']}, #{order['add_time']}, unix_timestamp(#{Time.now.to_i}),
        '#{@rds.escape order.to_json}', '#{@rds.escape text}'
    ) on duplicate key update
      oid = #{order['id']}, uid = #{order['uid']}, add_time = #{order['add_time']}, update_time = unix_timestamp(#{Time.now.to_i}),
      json = '#{@rds.escape order.to_json}', text = '#{@rds.escape text}'
    ;"

    order_time = Time.at(order['add_time']).strftime("%y%m%d-%H%M")
    page.store "id", "#{order['id']}"
    page.store "time", "#{order_time}"
    page.store "line", line
    page.store "phone", order['user_phone']
    page.store "text", text

    list += [page]

  end

  return list

end

orders = update_pickup_book_during stime, etime
orders.each do |order|
  fn = ".\\incoming\\" + order['time'] + "-order-" + order['line'] +  "-" + order['phone'] + ".txt"
  File.open(fn,"w:UTF-8") { |f| f.write order['text'] }
end
