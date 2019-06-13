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

#days count backward from today, defualt is 1, if count==0 then use tomrrow as shipdate
day_count = 1
silence_mode = false
if ARGV[0] == '-s' || ARGV[1] == '-s'
    day_count = ARGV[0].to_i if ARGV[0] != '-s'
    silence_mode = true 
else
    day_count = ARGV[0].nil? ? 1 : ARGV[0].to_i
end

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

#Z: 自提 C: 承诺达 G:广州 Q:祈福 P:番禺自送 K：快递 T:团购 X:问题单
lines = ["[A]", "[B]", "[C]", "[D]", "[E]", "[F]", "[G]", "[H]", "[I]", "[J]", "[K]", "[L]", "[M]", "[N]", "[O]", "[P]", "[Q]", "[R]", "[S]", "[T]", "[U]", "[V]", "[W]", "[X]", "[Y]","[Z]"]
routes = {}
line_data = {}
lines.each do |line| 
        line_data[line] = {}
        routes[line] = {} 
end

amt = 0.0
forders.each do |forder|
    order = forder[:order]
    line = forder[:line]

    comment = forder[:comment]
    comment = "#{forder[:first_item]} #{forder[:comment]}"  if line == '[T]'

    info =  " #{forder[:addr]} [#{forder[:short_number]}]LFCR  #{forder[:mark]}#{forder[:name]} #{forder[:tel]} #{comment}LFCR"
    info += "  :::#{forder[:date_time]} #{forder[:number]} #{forder[:amt]}\n" # " :::" 用于生成派线表时作为分割识别

    if line != '[X]'
        #merge non-X line orders summary when has same addr
        info = "*" + routes[line][forder[:addr]] if routes[line].has_key? forder[:addr]
        routes[line].store(forder[:addr],info)
        amt += order['totalAmount']
    else
        routes[line].store(forder[:number],info)
    end

    csv=[ '丰巢小蜜','18998382701','广州市番禺区汉溪村汉溪路6号201', 
          forder[:name],forder[:tel],forder[:addr], '生鲜','寄付',sprintf('%d',forder[:amt]/10),"1000",comment,forder[:date]+'-'+forder[:number]
    ]
    line_data[line].store(forder[:number],csv) #if want to avoid duplicate use contactTel

end

merged_orders = 0
lines.each do  |line|
  rday =Date.today.strftime('%Y-%m-%d')
  rtime=Time.now.strftime("%H%M%S")
  rdex = 1
  show_content =  "\n>>> Route #{line} <<<\n"
  print_content = ">>> 分线单 #{line}  #{Time.now.to_s} <<<\n"
  routes[line].sort_by{|_key, value| value}.to_h.each { |tel, info|
    merged_orders += 1 if line!= '[X]'
    #生成显示内容,每条订单一行不包括换行
    s_info = info.gsub('LFCRLFCR','LFCR').gsub('LFCR',' ').gsub('[  ]','').gsub(':::','  ').gsub('  ',' ').gsub('  ',' ').gsub('  ',' ')
    show_content += "#{sprintf('%02d',rdex)} " + s_info
    #生成打印内容,每条订单占两行,不含日期订单号金额等信息
    p_info = info.gsub('LFCR',"\n").split("  :::")[0]
    print_content += "#{sprintf('%02d',rdex)} " + p_info
    rdex +=1
  }
  if routes[line].size!= 0 
    #显示订单信息
    puts show_content
    #生成派线单
    if !silence_mode

        fn_name = ".\\incoming\\" + rday + "-line-" + line[1] + "-" + rtime + ".txt"
        File.open(fn_name,"w:UTF-8") { |f| f.write print_content }

        save_line_excel line[1], line_data[line] #line[1] means 'P','G','Q' etc
    end
  end 
 
  #保存派线单数据
  #if line_data[line].size!=0
  #  save_line_excel line[1], line_data[line] #line[1] means 'P','G','Q' etc
  #end
end

puts "------------------------------------"
puts "Valid orders: #{merged_orders}/#{forders.count-routes['[X]'].count} RMB#{amt}"
