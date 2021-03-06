﻿#encoding: utf-8
#this file shows all orders
#usage: brief.rb [backward_days [-m|-e]]
#   -m: start from morning 09:00:01
#   -e: start from evening 18:00:01
#   otherwise start from 00:00:00

require 'digest/md5'
require 'net/http'
require 'json'
require 'time'
require 'date'
require 'awesome_print'

load 'router.rb'
load 'get_orders.rb'
load 'wechat_api.rb'

oorders = []

#days count backward from today

day_count = ARGV[0].nil? ? 0 : ARGV[0].to_i
stime = ' 00:00:00'
stime = ' 09:00:01' if ARGV[1] == '-m' #start from morning
stime = ' 18:00:01' if ARGV[1] == '-e' #start from evening
stime = ' 00:00:01' if ARGV[1] == '-z' #start from midnight

eday = Date.today
etime = ' 23:59:59'
sday = Date.today
day_count.times do
    sday = sday.prev_day
end

s_time = sday.strftime('%Y-%m-%d') + stime
e_time = eday.strftime('%Y-%m-%d') + etime

oorders =  get_ogoods_orders_within s_time, e_time

#Z: 自提 C: 承诺达 G:广州 Q:祈福 P:番禺自送 K：快递 T:团购 X:问题单
LINES = ["[A]", "[B]", "[C]", "[D]", "[E]", "[F]", "[G]", "[H]", "[I]", "[J]", "[K]", "[L]", "[M]", "[N]", "[O]", "[P]", "[Q]", "[R]", "[S]", "[T]", "[U]", "[V]", "[W]", "[X]", "[Y]","[Z]"]
routes = {}
routes_sum = {} #记录每条线路的订单金额小计
line_data_sf_sufa = {}
line_data_sf_suda = {}
line_data_jd = {}
LINES.each do |line| 

        #merge all lines into one line[A] except line[X] and line[Z]
        actual_line = line
        #actual_line = '[A]' if line != '[X]' and line != '[Z]' and line != '[T]'

        line_data_sf_sufa[actual_line] = {}
        line_data_sf_suda[actual_line] = {}
        line_data_jd[actual_line] = {}
        routes[actual_line] = {} 
        routes_sum[actual_line] = 0
end

# 遍历订单集合，生成各条线路的打印(routes)及统计数据(line_data_sf, line_data_jd)
amt = 0.0
oorders.each do |oorder|
    raw_data = oorder[:raw_data].gsub("\n","").gsub("\t","")
    begin
    order = JSON.parse raw_data
    rescue Exception => e
      #puts e.message
      puts "#{oorder[:number]} Exception!!!"
      puts raw_data
      next
    end

    line = oorder[:line]
    #line = '[A]' if oorder[:line] != '[X]' and oorder[:line] != '[Z]'

    comment = oorder[:comment]
    comment = "#{oorder[:first_item]} #{oorder[:comment]}"  if line == '[T]'
    otime = order['orderDateTime'][10..20]

    attention = "##{oorder[:order_times]}"
    attention = "!!!!!!!" if oorder[:order_times] == 1

    info =  " #{oorder[:addr]} [#{oorder[:short_number]} #{otime}]LFCR  #{oorder[:name]} #{oorder[:tel]} #{comment} #{attention}LFCR"
    info += "  #{oorder[:tips]}\n" if oorder[:tips]!= ''
    info += "  :::#{oorder[:date_time]} #{oorder[:number]} #{sprintf("%.2f",oorder[:amount])}\n" # " :::" 用于生成派线表时作为分割识别
    routes_sum[line] += oorder[:amount]

    if line != '[X]'
        #merge non-X line orders summary when has same addr
        info = "*" + routes[line][oorder[:addr]] if routes[line].has_key? oorder[:addr]
        routes[line].store(oorder[:addr]+oorder[:tel],info)
        amt += oorder[:amount]
    else
        routes[line].store(oorder[:order_id],info)
    end

    # 承诺达的格式
    #csv=[ '丰巢小蜜','18998382701','广州市番禺区汉溪村汉溪路6号201', 
    #      oorder[:name],oorder[:tel],oorder[:addr], '生鲜','寄付',sprintf('%d',oorder[:items_count]),"1000",comment,odate+'-'+oorder[:order_id]
    #]

    #顺丰速发的格式
    csv_sf_sufa = ['',oorder[:number],'','','','',
           'FOODTRUST丰巢有机','黄冲','18148475667','广州市番禺区汉溪村汉溪路6号201',
           '',oorder[:name],oorder[:tel],oorder[:addr],
           '有机食品','','','','','',
           1,'顺丰即日','寄付月结','0207375546']
    #顺丰速打的格式
    csv_sf_suda = [oorder[:number],'FOODTRUST丰巢有机','黄冲','18998382701','广州市番禺区汉溪村汉溪路6号201',
           '',oorder[:name],'',oorder[:tel],oorder[:addr],
           '有机食品',oorder[:items_count],'','','寄付月结','顺丰即日',
           1,'顺丰即日','寄付月结']

    #京东的格式
    csv_jd = [oorder[:number],'',oorder[:name],oorder[:tel],'',oorder[:addr],'','有机食品','水果生鲜',oorder[:items_count],1,'','','特惠送','','寄付月结',oorder[:amount],'否','','','','','','']

    line_data_sf_sufa[line].store(oorder[:tel],csv_sf_sufa) #if want to avoid duplicate use tel, otherwise using oorder[:number]
    line_data_sf_suda[line].store(oorder[:tel],csv_sf_suda) #if want to avoid duplicate use tel, otherwise using oorder[:number]
    line_data_jd[line].store(oorder[:tel],csv_jd) #if want to avoid duplicate use tel, otherwise using oorder[:number]

end

#遍历路线集合，生产各条线路的可打印信息及EXCEL表
merged_orders = 0
['[K]','[P]','[G]','[Z]','[X]', '[T]'].each do  |line|

  rday =Date.today.strftime('%Y-%m-%d')
  rtime=Time.now.strftime("%H%M%S")
  rdex = 1
  show_content =  "\n>>> Route #{line} <<<\n"
  print_content = ">>> 分线单 #{line}  #{Time.now.to_s} <<<\n"
  body_content = "" #具体内容

  routes[line].sort_by{|_key, value| value}.to_h.each { |tel, info|
    merged_orders += 1 if line!= '[X]'
    #生成显示内容,每条订单一行不包括换行
    s_info = info.gsub('LFCRLFCR','LFCR').gsub('LFCR',' ').gsub('[  ]','').gsub(':::','  ').gsub('  ',' ').gsub('  ',' ').gsub('  ',' ')
    show_content += "#{sprintf('%02d',rdex)} " + s_info
    #生成打印内容,每条订单占两行,不含日期订单号金额等信息
    p_info = info.gsub('LFCR',"\n").split("  :::")[0]
    body_content += "#{sprintf('%02d',rdex)} " + p_info
    rdex +=1
  }

  print_content += body_content

  if routes[line].size!= 0 

    #显示订单信息
    puts show_content
    puts "-- line #{line} total amount: #{sprintf('%02d',routes_sum[line])}\n"

        #
        #生成派线单
        fn_name = ".\\incoming\\" + rday + "-line-" + line[1] + "-" + rtime + ".txt"
        File.open(fn_name,"w:UTF-8") { |f| f.write print_content }
        #
        #生成顺丰及京东数据
        save_line_excel_in_sf line[1], line_data_sf_suda[line] if line!='[Z]' && line !='[X]'
        save_line_excel_in_jd line[1], line_data_jd[line] if line!='[Z]' && line !='[X]'

        #send work wechat bot message
        msg_content = "#{rday} 分线单#{line} #{rtime}\n"
        list = []
        msg_content += "#{body_content}"
        send_bot_message msg_content,list

  end 
 
end

puts "------------------------------------"
puts "Valid orders: #{merged_orders}/#{oorders.count-routes['[X]'].count} RMB#{sprintf("%.2f",amt)}"
