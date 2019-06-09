#encoding: utf-8
#This ruby file will get new orders from pospal and save them to text file
#those text file will be printed to pdf printer and send to printer by powershell scripts

require 'mysql2'
require 'yaml'
require 'digest/md5'
require 'net/http'
require 'json'
require 'date'
require 'time'
load 'router.rb'
load 'get_orders.rb'

forders = []

silence_mode = false #silence mode will not generate order file
day_count = 1
if ARGV[1] == '-s' || ARGV[0] == '-s'
    day_count = ARGV[0].to_i if ARGV[0] != '-s'
    silence_mode = true
else
    day_count = ARGV[0].to_i if !ARGV[0].nil?
end

#let cron tab do weekday judegment
#day_count = 2 if Date.today.wday==0 && ARGV[0].nil? #if Sunday

#0 打印明天发货的
if day_count == 0
   the_day = Date.today.next_day
   forders = get_orders_by_shipdate the_day
else
   the_day = Date.today
   day_count.times do 
        forders += get_orders_by_shipdate the_day
        the_day = the_day.prev_day
   end
end

def update_orderdb forder

    order = forder[:order]

    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])

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
             print_times,ship_refunded,point_awarded,
             raw_data,plain_text
            ) VALUES 
            (
             '#{forder[:number]}',#{state},'#{pay_method}',#{pay_online},#{online_paid},
             #{amount},#{delivery_type},'#{order['customerNumber']}',#{shipping_fee},'#{zone_code}',
             '#{order['orderRemark']}','#{order['orderDateTime']}','#{forder[:name]}','#{forder[:addr]}','#{forder[:tel]}','#{forder[:line]}',
             0,0.0,0.0,
             '#{escaped_order_json}','#{escaped_plain_text}'
            )
            ON DUPLICATE KEY
            UPDATE state=#{state}, pay_method='#{pay_method}', pay_online=#{pay_online}, online_paid=#{online_paid},
            shipping_fee=#{shipping_fee}, delivery_type=#{delivery_type}, line='#{forder[:line]}',zone_code='#{zone_code}',
            raw_data='#{escaped_order_json}',plain_text='#{escaped_plain_text}'
           "
     resu = rds.query(sqlu)
end

forders.each do |forder|

    order = forder[:order]
    update_orderdb forder

    next if order['state'] == 3 #skip canceled order print
    next if order['state'].nil? && order['isOnLinePaymentCompleted'].nil? #skip print unfished order

    if !silence_mode
            rday =Date.today.strftime('%Y-%m-%d')
            rtime=Time.now.strftime("%H%M%S")
            fn_name = ".\\incoming\\" + rday + "-order-" + forder[:number] + "-c" + order['customerNumber'] + ".txt"
            File.open(fn_name,"w:UTF-8") do |f|
                f.write forder[:plain_text]
            end
    end
end
