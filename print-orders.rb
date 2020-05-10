#encoding: utf-8
#This ruby file will print crmeb orders for specific duration`

require 'time'
load 'rds_api.rb'

#puts 'Usage: ruby print-orders.rb [start_time backward_hours] [-s]'
#put 'eg: ruby print-orders.rb 2019-07-09 08:00 24'
=begin
  典型用法： 
  1) 无参数调用 ruby print-orders.rb
    相当于ruby order-man.rb current_time 24, 从现在倒推的24小时之内, 注意这个逻辑和order_man是有区别的
=end

etime = ( ARGV[0] && ARGV[1] ) ? Time.parse("#{ARGV[0]} #{ARGV[1]}") : Time.now
bhours = ARGV[2] ? ARGV[2].to_i : 24
stime = etime - bhours*3600 + 1 #leave one second

def get_crmeb_orders_during stime, etime
  orders=[]
  inq = "select * from crmeb.eb_store_order where add_time >= #{stime.to_i} and add_time <= #{etime.to_i};" #using unix_timestamp
  res = queryRds inq
  res.each do |r|
    orders += [r]
    p orders.to_json.size
  end
  return orders
end

orders = get_crmeb_orders_during stime, etime

exit

printf "Generating order text ["
orders.each do |order|
    printf "."
    if order[:state] == 1 && order[:online_paid] == 1
        #ship this order, next time will be printed as normal order
        req_body = { "orderNo": order[:full_order_number] }
        pospal_api :shipOrder, req_body
        pospal_api :completeOrder, req_body
        printf "!"
    end
    next if order[:line] == '[X]'
    next if order[:first_item].include?('产地直发') && order[:line]==['T'] #所有标注了产地直发的团购订单，并不打印, 这里有个bug，如果一张单是状态3已支付正好又包含直发商品
    if !silence_mode
        oday = order[:odate]
        fn_name = ".\\incoming\\" + oday + '-' + order[:number] + "-order-" + order[:line][1] +  "-c" + order[:customer_id] + ".txt"
        printf "w"
        File.open(fn_name,"w:UTF-8") do |f|
            f.write order[:plain_text]
        end
    end
end
printf "] Done\n"
