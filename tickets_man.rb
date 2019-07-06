#encoding: utf-8
#
#This file is used to pre-processed tickets read under access time limited
require 'awesome_print'
load 'get_orders.rb'

#stime = '2019-07-05 00:00:00'
#etime = '2019-07-05 23:59:59'
#tickets = get_pospal_tickets_within stime, etime

##list.txt is from "ls TORB* > list.txt"
#file = ".\\list.txt"
#IO.readlines(file).each do |line|
#        puts line[0..9]
#end
##ruby tickets_man.rb | sort | uniq > list2.txt


#tickets=JSON.parse IO.readlines(".\\auto_import\\tickets\\tickets.json")[0]
#ap tickets
stime = '2019-07-05 00:00:00'
etime = '2019-07-05 23:59:59'

file = ".\\list2.txt"
IO.readlines(file).each do |line|
        stime = line[0..9] + " 00:00:00"
        etime = line[0..9] + " 23:59:59"
        tickets = get_pospal_tickets_within stime, etime
        rtime = Time.now.strftime('%Y%m%d%H%M%S')
        fn = ".\\auto_import\\tickets\\tickets-" + stime.gsub('-','').gsub(':','').gsub(' ','') + '-' + etime.gsub('-','').gsub(':','').gsub(' ','') + '_' + rtime + ".json"
        File.open(fn,"w:UTF-8") { |f| f.write tickets.to_json }
end
