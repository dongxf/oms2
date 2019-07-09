#encoding: utf-8
#This ruby file will get pospal orders from specific days 

require 'mysql2' #initialize mysql connection here for performance
load 'get_orders.rb'

#puts 'Usage: ruby order_man.rb [start_date backward_counter] [-s]'
#puts 'eg: ruby order_man.rb 2019-07-09 2'

the_day = Date.today
counter = 2
silence_mode = false

the_day = Date.parse(ARGV[0]) if ARGV[0]
counter = ARGV[1].to_i if ARGV[1]
silence_mode = true if ARGV[2] == '-s'

jorders = []
counter.times do 
    stime = the_day.strftime('%Y-%m-%d') + " 00:00:00"
    etime = the_day.strftime('%Y-%m-%d') + " 23:59:59"
    jorders += get_orders_within stime, etime
    the_day = the_day.prev_day
end

rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])

jorders.each do |forder|
    order = forder[:order]
    update_order_by_json rds, forder
    next if order['state'] == 3 #skip canceled order print
    # next if order['state'].nil? && order['isOnLinePaymentCompleted'].nil? #skip print unfished order
    next if order['state']=='[X]'
    next if forder[:first_item].include?('产地直发') && forder[:line]==['T']

    if !silence_mode
        oday = forder[:odate]
        fn_name = ".\\incoming\\" + oday + "-order-" + forder[:line][1] + '-' + forder[:number] + "-c" + order['customerNumber'] + ".txt"
        File.open(fn_name,"w:UTF-8") do |f|
            f.write forder[:plain_text]
        end
    end
end
