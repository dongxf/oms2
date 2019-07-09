#encoding: utf-8
#This file is used to processed tickets data from pospal

require 'find'
require 'awesome_print'
load    'get_orders.rb'

def update_ticket_information rds, ticket
    sqlu = "INSERT INTO ogoods.pospal_tickets (
                    ticket_sn, ticket_date, customer_uid, order_number, raw_data
                ) VALUES (
                    '#{ticket['sn']}', '#{ticket['datetime']}', #{ticket['customerUid']}, '#{ticket['webOrderNo']}', '#{ticket.to_json.gsub("'","''")}'
                ) ON DUPLICATE KEY
                UPDATE 
                    ticket_sn = '#{ticket['sn']}', 
                    ticket_date = '#{ticket['datetime']}',
                    customer_uid = #{ticket['customerUid']}, 
                    order_number = '#{ticket['webOrderNo']}', 
                    raw_data = '#{ticket.to_json.gsub("'","''")}'
    "
    rds.query sqlu
end

def update_tickets_db tickets
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
    Find.find('.//auto_import//tickets') do |fn| #在该目录下不能有子文件夹
        next if !(fn.include? '.json') #要排除目录自身
        tickets = JSON.parse IO.readlines(fn)[0]
        update_tickets_db tickets
        total += tickets.size
        puts "#{sprintf('%2d',tickets.size)} tickets in #{fn}"
    end
    puts "total tickets readed: #{total}"
end

=begin
    Usage: to retrieve tickets since give date, last n days
    eg:    retrieve_json_data_since Date.today 1
    eg:    retrieve_json_data_since Date.parse('2019-03-01'), 31
=end

def retrieve_json_data_since day, count
    tickets = []
    puts "retrieving tickets data since #{day.to_s} backward #{count} days..."
    count.times do
        stime = day.strftime('%Y-%m-%d') + " 00:00:00"
        etime = day.strftime('%Y-%m-%d') + " 23:59:59"
        puts "  retrieving tickets during #{stime} - #{etime}"
        tickets += get_pospal_tickets_within(stime, etime)
        day = day.prev_day
    end
    puts "done. total tickets: #{tickets.size}"
    return tickets
end

p 'usage: ruby tckets_man.rb [start_date backward_total_days]'
p 'eg: ruby tickets_man.rb 2019-07-09 2'
start_day = Date.today
backward_count = 2
start_day = Date.parse(ARGV[0]) if ARGV[0]
backward_count = ARGV[1].to_i if ARGV[1]

tickets = retrieve_json_data_since start_day, backward_count
update_tickets_db tickets
