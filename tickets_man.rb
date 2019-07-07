#encoding: utf-8

#This file is used to pre-processed tickets read under access time limited

require 'find'
require 'awesome_print'
load    'get_orders.rb'

=begin
    Usage: to import all json data under certain direcoties
    eg:    retrieve_json_data_since Date.today 1
    eg:    retrieve_json_data_since Date.parse('2019-03-01'), 31
=end
def import_json_data
    total = 0 
    Find.find('.//auto_import//tickets') do |fn|
        if fn.include? 'json'
            tickets = JSON.parse IO.readlines(fn)[0]
            total += tickets.size
            puts "#{tickets.size} tickets in #{fn}"
        end
    end
    puts "total: #{total}"
end

<<<<<<< HEAD
day = Date.today
130.times do
    stime = day.strftime('%Y-%m-%d') + " 00:00:00"
    etime = day.strftime('%Y-%m-%d') + " 23:59:59"
    #break_day = Date.parse('2019-06-06')
    day = day.prev_day
    #next if day >= break_day
    puts "retrieving tickets during #{stime} - #{etime}"
    tickets = get_pospal_tickets_within stime, etime #this function already save json file
=======
=begin
    Usage: to retrieve tickets since
    eg:    retrieve_json_data_since Date.today 1
    eg:    retrieve_json_data_since Date.parse('2019-03-01'), 31
=end
def retrieve_json_data_since day, count
    count.times do
        stime = day.strftime('%Y-%m-%d') + " 00:00:00"
        etime = day.strftime('%Y-%m-%d') + " 23:59:59"
        puts "retrieving tickets during #{stime} - #{etime}"
        #tickets = get_pospal_tickets_within stime, etime #this function already save json file
        day = day.next_day
    end
>>>>>>> eaf1133a7b66e50032ea911913db345b68de4e1e
end

retrieve_json_data_since Date.parse('2019-03-01'), 1
