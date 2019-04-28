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

forders = []

#days count backward from today, if days==0 then use tomrrow as shipdate
day_count = ARGV[0].nil? ? 1 : ARGV[0].to_i

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

#Z: 自提 C: 承诺达 G:广州 Q:祈福弃用 P:番禺自送 K：快递 T:团购 X:问题单
#目前使用Z G P K T X
lines = ['[Z]','[G]','[P]','[K]', '[T]', '[X]']
routes = {}
line_data = {}
lines.each do |line| 
        line_data[line] = {}
        routes[line] = {} 
end

amt = 0.0
good_orders = 0
forders.each do |forder|
    order = forder[:order]

    info =  " #{forder[:addr]} [  ]LFCR"
    info += "  #{forder[:mark]}#{forder[:name]} #{forder[:tel]} #{forder[:comment]}LFCR"
    info += "  :::#{forder[:date_time]} #{forder[:number]} #{forder[:amt]}\n" # " :::" 用于生成派线表时作为分割识别

    line = forder[:line]
    if routes[line].has_key? forder[:addr]
        info = "*" + routes[line][forder[:addr]]
    end
    routes[line].store(forder[:addr],info) #using addr to merge orders

    csv=[ '丰巢小蜜','18998382701','广州市番禺区汉溪村汉溪路6号201', 
          forder[:name],forder[:tel],forder[:addr], '生鲜','寄付',sprintf('%d',forder[:amt]/10),"1000",forder[:comment],forder[:date]+'-'+forder[:number]
    ]
    line_data[line].store(forder[:number],csv) #if want to avoid duplicate use contactTel

    if line!='[X]'
        amt += order['totalAmount']
        good_orders +=1
    end

end

merged_orders = 0
lines.each do  |line|
  rday =Date.today.strftime('%Y-%m-%d')
  rtime=Time.now.strftime("%H%M%S")
  rdex = 1
  show_content =  "\n>>> Route #{line} <<<\n"
  print_content = "\n\n\n>>>>>>>>>>  路线交付表 #{line} <<<<<<<<<<\n #{Time.now.to_s}\n\n"
  routes[line].sort_by{|_key, value| value}.to_h.each { |tel, info|
    merged_orders += 1
    s_info = info.gsub('LFCRLFCR','LFCR').gsub('LFCR',' ').gsub('[  ]','').gsub(':::','  ').gsub('  ',' ').gsub('  ',' ').gsub('  ',' ')
    show_content += "#{sprintf('%02d',rdex)} " + s_info
    rdex +=1
  }
  if routes[line].size!= 0 
    puts show_content
  end 
end

puts "------------------------------------"
puts "Total: " + " >>" + " #{merged_orders} of #{forders.count} RMB#{amt}"
