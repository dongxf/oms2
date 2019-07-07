#encoding: utf-8

#This file is used to processed tickets data from pospal

require 'find'
require 'awesome_print'
load    'get_orders.rb'

def update_ticket_information rds, ticket
end

def update_tickets_in_ogoods tickets
    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'], :encoding => 'utf8mb4' )
    tickets.each { |ticket| update_ticket_information rds, ticket }
end

=begin
    Usage: to import all json data under certain direcoties
    eg:    retrieve_json_data_since Date.today 1
    eg:    retrieve_json_data_since Date.parse('2019-03-01'), 31
=end
def import_json_data
    total = 0 
    Find.find('.//auto_import//tickets') do |fn|
        if (fn.include? '.json') && !(fn.include? 'old') #要排除old为名的子目录或文件
            tickets = JSON.parse IO.readlines(fn)[0]
            update_tickets_in_ogoods tickets
            total += tickets.size
            puts "#{sprintf('%2d',tickets.size)} tickets in #{fn}"
        end
    end
    puts "total tickets readed: #{total}"
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
    Usage: to retrieve tickets since give date, last n days
    eg:    retrieve_json_data_since Date.today 1
    eg:    retrieve_json_data_since Date.parse('2019-03-01'), 31
=end
def retrieve_json_data_since day, count
    count.times do
        stime = day.strftime('%Y-%m-%d') + " 00:00:00"
        etime = day.strftime('%Y-%m-%d') + " 23:59:59"
        puts "retrieving tickets during #{stime} - #{etime}"
        tickets = get_pospal_tickets_within stime, etime #this function already save json file
        day = day.next_day
    end
>>>>>>> eaf1133a7b66e50032ea911913db345b68de4e1e
end

import_json_data
