#encoding: utf-8
#this file shows all orders

require 'digest/md5'
require 'net/http'
require 'json'
require 'time'
require 'date'
require 'awesome_print'

load 'router.rb'
load 'get_orders.rb'

the_day = Date.today
orders = []
1.times do 
    orders += get_orders_by_shipdate the_day
    the_day = the_day.prev_day
end

lines = ['[Z]','[C]','[G]','[Q]','[P]','[K]', '[T]']
routes = {}
line_data = {}
lines.each do |line| 
        line_data[line] = {}
        routes[line] = {} 
end

index = -1
amt = 0.0
good_orders = 0
orders.each do |order|
    index +=1 
    next if order['state'] == 3

    amt += order['totalAmount']
    good_orders +=1 if order['state'] == 4

    slim_addr=get_short_addr order
    slim_name = get_short_name order
    odrmk = "#{get_noti order} #{get_short_remark order}"
    batch_mark =  get_batch_mark order
    short_no = get_short_no order

    addr = "#{batch_mark} #{short_no} #{order['orderDateTime']}"
    addr += " #{slim_addr} #{slim_name} #{order['contactTel']} #{order['totalAmount']} | #{odrmk}\n"

    line = decide_route order
    addr = "** " + addr if routes[line].has_key? slim_addr && line!='[T]'
    routes[line].store(slim_addr,addr) #using slim_addr will merge orders

    ship_info=[ '丰巢小蜜','18998382701','广州市番禺区汉溪村汉溪路6号201',slim_name,order['contactTel'],slim_addr,'生鲜','寄付',order['totalAmount']/10,"999",odrmk,short_no]
    line_data[line].store(short_no,ship_info) #if want to avoid duplicate use contactTel

end

merged_orders = 0
lines.each do  |line|
  rdex = 1
  content = ">>>>>>>>>>  Route #{line} <<<<<<<<<<\n"
  routes[line].sort_by{|_key, value| value}.to_h.each { |tel, addr|
    merged_orders += 1
    content += "#{rdex})" + addr
    rdex +=1
  }
  if routes[line].size!= 0 
    puts content
  end 
  if line_data[line].size!=0
    save_line_excel line, line_data[line]
  end
end

puts "------------------------------------"
#puts "Total: " + s_time + "--" + e_time + " >>" + " #{merged_orders} of #{orders.count} RMB#{amt}"
puts "Total: " + " >>" + " #{merged_orders} of #{orders.count} RMB#{amt}"
