#encoding: utf-8
#This ruby file will get pospal orders from specific days 

require 'mysql2'
require 'yaml'
require 'digest/md5'
require 'net/http'
require 'json'
require 'date'
require 'time'
load 'router.rb'
load 'get_orders.rb'

if !( ARGV[0] && ARGV[1] )
        p 'usage: back_orders start_day days'
        p 'eg: ruby back_orders 2019-03-01 4'
        return
end
the_day = Date.strptime(ARGV[0],"%Y-%m-%d")
day_count = ARGV[1].to_i

forders = []
silence_mode = true
day_count.times do 
        forders += get_orders_by_shipdate the_day
        the_day = the_day.next_day
end

def update_orderdb rds, forder

    order = forder[:order]

    #convert nil values to zero or ''
    state = order['state'].nil? ? -1 : order['state']
    pay_method = order['payMethod'].nil? ? '' : order['payMethod']
    pay_online = order['payOnLine'].nil? ? -1 : order['payOnLine']
    shipping_fee = order['shippingFee'].nil? ? 0.0 : order['shippingFee']
    zone_code = forder[:zone_code]
    online_paid = order['isOnlinePaymentCompleted'].nil? ? 0 : order['isOnlinePaymentCompleted']
    amount = order['totalAmount'].nil? ? 0.0 : order['totalAmount']
    delivery_type = order['deliveryType'].nil? ? -1 : order['deliveryType']
    escaped_order_json = order.to_json.gsub("'","''") #用于SQL语句中的转义
    escaped_plain_text = forder[:plain_text].gsub("'","''")

    sqlu = "INSERT INTO ogoods.pospal_orders
            (
             order_id,state,pay_method,pay_online,online_paid,
             amount,delivery_type,customer_id,shipping_fee,zone_code,
             remark,order_time,name,addr,tel,line,
             mark,number,short_number,date_time,short_time,
             odate,date,
             first_item,items_count,
             print_times,ship_refunded,point_awarded,
             raw_data,plain_text
            ) VALUES 
            (
             '#{forder[:number]}',#{state},'#{pay_method}',#{pay_online},#{online_paid},
             #{amount},#{delivery_type},'#{order['customerNumber']}',#{shipping_fee},'#{zone_code}',
             '#{order['orderRemark']}','#{order['orderDateTime']}','#{forder[:name]}','#{forder[:addr]}','#{forder[:tel]}','#{forder[:line]}',
             '#{forder[:mark]}', '#{forder[:number]}', '#{forder[:short_number]}', '#{forder[:date_time]}', '#{forder[:short_time]}', 
             '#{forder[:odate]}', '#{forder[:date]}', 
             '#{forder[:first_item]}', #{forder[:items_count]},
             0,0.0,0.0,
             '#{escaped_order_json}','#{escaped_plain_text}'
            )
            ON DUPLICATE KEY
            UPDATE state=#{state}, pay_method='#{pay_method}', pay_online=#{pay_online}, online_paid=#{online_paid},
            delivery_type=#{delivery_type}, shipping_fee=#{shipping_fee}, zone_code='#{zone_code}',
            line='#{forder[:line]}',
            mark='#{forder[:mark]}',number='#{forder[:number]}',short_number='#{forder[:short_number]}',date_time='#{forder[:date_time]}',short_time='#{forder[:short_time]}',
            odate='#{forder[:odate]}',date='#{forder[:date]}', 
            first_item='#{forder[:first_item]}',items_count=#{forder[:items_count]},
            raw_data='#{escaped_order_json}',plain_text='#{escaped_plain_text}'
           "
     resu = rds.query(sqlu)
     p "order #{forder[:number]} inserted"
end

forders.each do |forder|

    order = forder[:order]
    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])

    update_orderdb rds, forder

    next if order['state'] == 3 #skip canceled order print
    # next if order['state'].nil? && order['isOnLinePaymentCompleted'].nil? #skip print unfished order
    next if order['state']=='[X]'
    next if forder[:first_item].include?('产地直发') && forder[:line]==['T']

    if !silence_mode
            rday =Date.today.strftime('%Y-%m-%d')
            rtime=Time.now.strftime("%H%M%S")
            oday = forder[:odate]
            fn_name = ".\\incoming\\" + oday + "-order-" + forder[:line][1] + '-' + forder[:number] + "-c" + order['customerNumber'] + ".txt"
            File.open(fn_name,"w:UTF-8") do |f|
                f.write forder[:plain_text]
            end
    end
end
