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

def someOrder
  return {"id"=>1, "order_id"=>"wx158908210027090511", "uid"=>1, "real_name"=>"董学锋", "user_phone"=>"13600060044", "user_address"=>"广东省 广州市 番禺区 钟村街汉溪村汉溪路6号201", "cart_id"=>"[2,1]", "freight_price"=>0.0, "total_num"=>2, "total_price"=>0.4165e2, "total_postage"=>0.0, "pay_price"=>0.0, "pay_postage"=>0.12e2, "deduction_price"=>0.5365e2, "coupon_id"=>0, "coupon_price"=>0.0, "paid"=>1, "pay_time"=>1589082100, "pay_type"=>"yue", "add_time"=>1589082100, "status"=>0, "refund_status"=>0, "refund_reason_wap_img"=>nil, "refund_reason_wap_explain"=>nil, "refund_reason_time"=>nil, "refund_reason_wap"=>nil, "refund_reason"=>nil, "refund_price"=>0.0, "delivery_name"=>nil, "delivery_type"=>nil, "delivery_id"=>nil, "gain_integral"=>0.38e2, "use_integral"=>0.5365e4, "back_integral"=>nil, "mark"=>"", "is_del"=>0, "unique"=>"0dc397cb2ea6f90707bc72fcd57abc71", "remark"=>nil, "mer_id"=>0, "is_mer_check"=>0, "combination_id"=>0, "pink_id"=>0, "cost"=>0.3e2, "seckill_id"=>0, "bargain_id"=>0, "verify_code"=>"", "store_id"=>0, "shipping_type"=>1, "clerk_id"=>0, "is_channel"=>1, "is_remind"=>1, "is_system_del"=>0, "items"=>[{"oid"=>1, "cart_id"=>2, "product_id"=>2, "cart_info"=>"{\"id\":2,\"type\":\"product\",\"product_id\":2,\"product_attr_unique\":\"d9b33bbe\",\"cart_num\":1,\"combination_id\":0,\"seckill_id\":0,\"bargain_id\":0,\"productInfo\":{\"id\":2,\"image\":\"https:\\/\\/oss.foodtrust.cn\\/\\/e0792202004252022151244.png\",\"price\":\"19.00\",\"ot_price\":\"29.00\",\"vip_price\":\"0.00\",\"postage\":\"0.00\",\"give_integral\":\"29.00\",\"sales\":0,\"stock\":4000,\"store_name\":\"\\u6d4b\\u8bd5\\u5546\\u54c1\\u4e59-\\u591a\\u89c4\\u683c\",\"unit_name\":\"\\u4efd\",\"is_postage\":0,\"cost\":\"9.00\",\"is_sub\":0,\"temp_id\":2,\"attrInfo\":{\"product_id\":2,\"suk\":\"\\u8170\\u82b1\",\"stock\":1000,\"sales\":0,\"price\":\"39.00\",\"image\":\"https:\\/\\/oss.foodtrust.cn\\/\\/e0792202004252022151244.png\",\"unique\":\"d9b33bbe\",\"cost\":\"29.00\",\"bar_code\":\"646460-2\",\"ot_price\":\"49.00\",\"weight\":\"0.50\",\"volume\":\"0.01\",\"brokerage\":\"0.00\",\"brokerage_two\":\"0.00\",\"type\":0,\"quota\":0,\"quota_show\":0}},\"truePrice\":33.15,\"vip_truePrice\":5.85,\"trueStock\":1000,\"costPrice\":\"29.00\"}", "unique"=>"3c59dc048e8850243be8079a5c74d079"}, {"oid"=>1, "cart_id"=>1, "product_id"=>1, "cart_info"=>"{\"id\":1,\"type\":\"product\",\"product_id\":1,\"product_attr_unique\":\"d21a1d77\",\"cart_num\":1,\"combination_id\":0,\"seckill_id\":0,\"bargain_id\":0,\"productInfo\":{\"id\":1,\"image\":\"https:\\/\\/oss.foodtrust.cn\\/\\/7739c202004250337006643.jpg\",\"price\":\"9.99\",\"ot_price\":\"19.99\",\"vip_price\":\"0.00\",\"postage\":\"0.00\",\"give_integral\":\"9.00\",\"sales\":35,\"stock\":1000,\"store_name\":\"\\u65e7\\u7cfb\\u7edf\\u5931\\u6548\\u5546\\u54c1\\u8d2d\\u4e70\\u8bb0\\u5f55\\u8fc1\\u79fb\\u7528-\\u5e26\\u89c6\\u9891\",\"unit_name\":\"\\u76d2\",\"is_postage\":0,\"cost\":\"1.00\",\"is_sub\":0,\"temp_id\":1,\"attrInfo\":{\"product_id\":1,\"suk\":\"\\u9ed8\\u8ba4\",\"stock\":1000,\"sales\":0,\"price\":\"9.99\",\"image\":\"https:\\/\\/oss.foodtrust.cn\\/\\/7739c202004250337006643.jpg\",\"unique\":\"d21a1d77\",\"cost\":\"1.00\",\"bar_code\":\"0000000\",\"ot_price\":\"19.99\",\"weight\":\"1.00\",\"volume\":\"0.01\",\"brokerage\":\"0.00\",\"brokerage_two\":\"0.00\",\"type\":0,\"quota\":0,\"quota_show\":0}},\"truePrice\":8.5,\"vip_truePrice\":1.49,\"trueStock\":1000,\"costPrice\":\"1.00\"}", "unique"=>"6512bd43d9caa6e02c990b0a82652dca"}]}
end

def get_crmeb_orders_during stime, etime

  orders = []
  res = queryRds "select * from crmeb.eb_store_order where add_time >= #{stime.to_i} and add_time <= #{etime.to_i};" #using unix_timestamp
  res.each do |order|

    #append cart itmes to records
    items = []
    res2 = queryRds "select * from crmeb.eb_store_order_cart_info where oid = #{order['id']};"
    res2.each { |r2| items += [r2] }
    order.store "items", items

    #update orders information to fc_order_book with generating plain text
    text = genOrderText order

    queryRds "insert into crmeb.fc_order_book ( oid, uid, add_time, update_time, json, text) values (
        #{order['id']}, #{order['uid']}, #{order['add_time']}, unix_timestamp(#{Time.now.to_i}),
        '#{@rds.escape order.to_json}', '#{@rds.escape text}'
    ) on duplicate key update
      oid = #{order['id']}, uid = #{order['uid']}, add_time = #{order['add_time']}, update_time = unix_timestamp(#{Time.now.to_i}),
      json = '#{@rds.escape text}', text= '#{@rds.escape text}'
    ;"

    orders += [order]

  end

  return orders

end
#get_crmeb_orders_during stime, etime

def genOrderText order
  ap order
  return 'hjsdf'
end

p genOrderText someOrder
