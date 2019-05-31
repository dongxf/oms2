#This file will refund ship fee for qualified orders

require 'date'
require 'time'

load 'get_orders.rb'

def should_refund order
        return false if order[:shipping_fee] <= 0 #没有收过运费
        return false if ship_refunded > 0 #已经退回过
        return false if !addr_qualifed(order[:addr]) #
        return true if order[:zone_code] =='ZB' && order[:amount]>=88
        return true if order[:zone_code] =='SW'
        return false
end

oorders = []

#days count backward from today, defualt is 1, if count==0 then use tomrrow as shipdate
day_count = ARGV[0].nil? ? 1 : ARGV[0].to_i
day_count = 2 if Date.today.wday==0 && ARGV[0].nil? #if Sunday

if day_count == 0
   the_day = Date.today.next_day
   oorders = get_ogoods_orders_by_shipdate the_day
else
   the_day = Date.today
   day_count.times do 
        oorders += get_ogoods_orders_by_shipdate the_day
        the_day = the_day.prev_day
   end
end

oorders.each do |order|
    zc = get_zone_code JSON.parse(order[:raw_data])
    order_id = order[:order_id]
    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])
    sqlu = "update ogoods.pospal_orders set zone_code='#{zc}' where order_id = #{order_id}"
    resu = rds.query(sqlu)
    
end
