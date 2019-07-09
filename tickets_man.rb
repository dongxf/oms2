#encoding: utf-8
#This file is used to processed tickets data from pospal

require 'find'
require 'awesome_print'
load    'get_orders.rb'

def update_tickets_table rds, ticket
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

def update_orders_with_ticket rds, ticket
    order_number = ticket['webOrderNo']
    return if order_number.nil? ||  order_number == ''
    order_number = order_number[0..16] #remove 104
    puts "updating points_used in order ##{order_number} by ticket"
    points = points_used_by_ticket(ticket)
    return if points <= 0.0
    sqlu = "update ogoods.pospal_orders set points_used=#{sprintf('%.2f',points)} where order_id = '#{order_number}'"
    rds.query(sqlu)
end

def update_tickets_in_db tickets
    puts "updating tickets in goods.pospal_tickes..."
    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'], :encoding => 'utf8mb4' )
    tickets.each { |ticket| 
        update_tickets_table rds, ticket 
        update_orders_with_ticket rds, ticket
    }
    puts "done. total tickets: #{tickets.size}"
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
        update_tickets_in_db tickets
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
        tcks = get_pospal_tickets_within(stime, etime)
        tickets += tcks
        day = day.prev_day
        puts "  done. total tickets: #{tcks.size}"
    end
    puts "done. total tickets: #{tickets.size}"
    return tickets
end

def get_demo_tickets
    tickets = []
    Find.find('.//auto_import//tickets') do |fn| #在该目录下不能有子文件夹
        next if !(fn.include? '.json') #要排除目录自身
        tickets += JSON.parse IO.readlines(fn)[0]
        break
    end
    return tickets
end

def get_all_tickets
    tickets = []
    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'], :encoding => 'utf8mb4' )
    sqlu = "select raw_data from ogoods.pospal_tickets"
    res = rds.query(sqlu)
    res.each do |r|
        ticket = JSON.parse(r['raw_data'])
        tickets += [ ticket ] if ticket
    end
    return tickets
end

def ticket_payment_details ticket
    details = {}
    ticket['payments'].each do |pm|
        case pm['code']
        when 'payCode_17'
            details.store(:weixin, pm['amount'])
        when 'payCode_10'
            details.store(:points, pm['amount'])
        when 'payCode_7'
            details.store(:balance, pm['amount'])
        else
            details.store(pm['code'], pm['amount'])
        end
    end
    return details
end

def points_used_by_ticket ticket
    return ticket['pointUsage']['point'] if ticket['pointUsage']
    return 0.0
end

puts 'Usage: ruby tckets_man.rb [start_date backward_total_days]'
puts 'eg: ruby tickets_man.rb 2019-07-09 2'
start_day = Date.today
backward_count = 2
start_day = Date.parse(ARGV[0]) if ARGV[0]
backward_count = ARGV[1].to_i if ARGV[1]

#tickets = get_all_tickets
#tickets = get_demo_tickets
tickets = retrieve_json_data_since start_day, backward_count
update_tickets_in_db tickets
