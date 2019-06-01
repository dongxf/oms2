#encoding: utf-8
#this file shows all orders

require 'mysql2'
require 'digest/md5'
require 'net/http'
require 'json'
require 'time'
require 'date'
require 'awesome_print'

load 'router.rb'
load 'pospal_api.rb'

def get_orders_by_shipdate ship_day
        yesterday = ship_day.prev_day
        s_time = yesterday.strftime('%Y-%m-%d') + ' 15:00:01'
        e_time = ship_day.strftime('%Y-%m-%d') + ' 15:00:00'
        return get_orders_within s_time, e_time
end

def get_orders_by_day someday
        s_time = someday.strftime('%Y-%m-%d') + ' 00:00:00'
        e_time = someday.strftime('%Y-%m-%d') + ' 23:59:59'
        return get_orders_within s_time, e_time
end

# pospal only support to query orders within 24 hours
def get_orders_within s_time, e_time

        forders=[]

        puts "retrieving orders between #{s_time} and  #{e_time}\n"

        req = { 'startTime'=> s_time, 'endTime'=> e_time }
        res=pospal_api(:queryOrderPages,req)
        orders = res['data']['result']

        orders.each do |order|
            slim_addr=get_short_addr order
            slim_name = get_short_name order
            odrmk = "#{get_noti order} #{get_short_remark order}"
            batch_mark =  get_batch_mark order
            short_no = get_short_no order
            forders += [{
                    :line => decide_route(order),
                    :mark => get_batch_mark(order),
                    :number => get_short_no(order),
                    :zone_code => get_zone_code(order),
                    :short_number => get_short_no(order)[12..16],
                    :date_time => order['orderDateTime'],
                    :short_time => order['orderDateTime'][5..20],
                    :name => get_short_name(order),
                    :addr => get_short_addr(order),
                    :tel => order['contactTel'],
                    :amt => order['totalAmount'],
                    :comment => get_noti(order) + get_short_remark(order),
                    :date => get_short_date(order),
                    :plain_text => get_plain_text(order),
                    :order => order
            }]

        end
        return forders
end

def get_ogoods_orders_by_shipdate ship_day
        yesterday = ship_day.prev_day
        s_time = yesterday.strftime('%Y-%m-%d') + ' 15:00:01'
        e_time = ship_day.strftime('%Y-%m-%d') + ' 15:00:00'
        return get_ogoods_orders_within s_time, e_time
end

def get_ogoods_orders_by_day someday
        s_time = someday.strftime('%Y-%m-%d') + ' 00:00:00'
        e_time = someday.strftime('%Y-%m-%d') + ' 23:59:59'
        return get_ogoods_orders_within s_time, e_time
end

# pospal only support to query orders within 24 hours
def get_ogoods_orders_within s_time, e_time

        oorders=[]

        puts "retrieving ogoods orders between #{s_time} and  #{e_time}\n"

        rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])
        sqlu = "select * from ogoods.pospal_orders where order_time > '#{s_time}' and order_time < '#{e_time}'"
        resu = rds.query(sqlu)
        resu.each do |r|
            comment = r['comment'].nil? ? '' : r['comment']
            oorders += [{
                    :order_id => r['order_id'],
                    :state => r['state'],
                    :pay_method => r['pay_method'],
                    :pay_online => r['pay_online'],
                    :online_paid => r['online_paid'],
                    :amount => r['amount'],
                    :delivery_type => r['delivery_type'],
                    :customer_id => r['customer_id'],
                    :shipping_fee => r['shipping_fee'],
                    :remark => r['remark'],
                    :order_time => r['order_time'],
                    :name => r['name'],
                    :addr => r['addr'],
                    :tel => r['tel'],
                    :line => r['line'],
                    :zone_code => r['zone_code'],
                    :comment => comment,
                    :print_times => r['print_times'],
                    :plain_text => r['plain_text'],
                    :raw_data => r['raw_data'],
                    :ship_refunded => r['ship_refunded'],
                    :point_awarded => r['point_awarded']
            }]

        end
        return oorders
end
