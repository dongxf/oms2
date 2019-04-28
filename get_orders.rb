#encoding: utf-8
#this file shows all orders

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

        puts "retrieving orders within: #{s_time} ... #{e_time}\n"

        req = { 'startTime'=> s_time, 'endTime'=> e_time }
        res=pospal_api(:queryOrderPages,req)
        orders = res['data']['result']
        return orders
end
