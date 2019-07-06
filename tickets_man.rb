#encoding: utf-8
#
#This file is used to pre-processed tickets read under access time limited
require 'awesome_print'
load 'get_orders.rb'

stime = '2019-07-05 00:00:00'
etime = '2019-07-05 23:59:59'
#tickets = get_pospal_tickets_within stime, etime
#IO.readlines(".\\list.txt").each { |line|  puts line[0..9] }
#tickets=JSON.parse IO.readlines(".\\auto_import\\tickets\\tickets.json")[0]

day = Date.today # day = Date.parse('2019-02-26')
day_count = 48
day_count.times do
    stime = day.strftime('%Y-%m-%d') + " 00:00:00"
    etime = day.strftime('%Y-%m-%d') + " 23:59:59"
    puts "retrieving tickets during #{stime} - #{etime}"
    tickets = get_pospal_tickets_within stime, etime #this function already save json file
    day = day.prev_day
end
