#encoding: utf-8
#This ruby file will get pospal orders from specific days 

require 'mysql2' #initialize mysql connection here for performance
load 'get_orders.rb'

#puts 'Usage: ruby order_man.rb [start_date backward_counter] [-s]'
#put 'eg: ruby order_man.rb 2019-07-09 2'

the_day = Date.today
counter = 1
silence_mode = false

the_day = Date.parse(ARGV[0]) if ARGV[0]
counter = ARGV[1].to_i if ARGV[1]
silence_mode = true if ARGV[2] == '-s'

orders = []
counter.times do 
    if the_day == Date.today #没办法，就得节省API调用次数啊
        stime = (DateTime.now - 1).to_time.strftime('%Y-%m-%d %H:%M:%S')
        etime = (Time.now - 2).strftime('%Y-%m-%d %H:%M:%S')
    else
        stime = the_day.strftime('%Y-%m-%d') + " 00:00:00"
        etime = the_day.strftime('%Y-%m-%d') + " 23:59:59"
    end
    puts "#{stime} - #{etime}"
    orders += get_orders_within stime, etime
    the_day = the_day.prev_day
end

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
        fn_name = ".\\incoming\\" + oday + "-order-" + order[:line][1] + '-' + order[:number] + "-c" + order[:customer_id] + ".txt"
        printf "w"
        File.open(fn_name,"w:UTF-8") do |f|
            f.write order[:plain_text]
        end
    end
end
printf "] Done\n"
