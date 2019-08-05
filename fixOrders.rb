#encoding: utf-8
#those text file will be printed to pdf printer and send to printer by powershell scripts

require 'mysql2'
require 'yaml'
require 'digest/md5'
require 'net/http'
require 'json'
require 'date'
require 'time'
load 'router.rb'
load 'get_orders.rb'

@rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD']) if @rds.nil?

#re-calcaluated all first_item and item_counts for all existed recs
def gen_first_item
    sqlu = "select * from ogoods.pospal_orders"
    res = @rds.query(sqlu)
    res.each do |r|
        oid=r['order_id']

        if r['raw_data'].nil?
            sqlu = "UPDATE ogoods.pospal_orders set first_item='', items_count=0 where order_id='#{oid}'"
        else
            order = JSON.parse(r['raw_data'])
            items_count = 0
            if !order['items'].nil?
                order['items'].each do |itm|
                    items_count += itm['productQuantity'].to_i
                end
            end
            first_item = ''
            first_item = order['items'][0]['productName'] if !order['items'].nil? && !order['items'].empty?
            sqlu = "UPDATE ogoods.pospal_orders set first_item='#{first_item}', items_count=#{items_count} where order_id='#{oid}'"
        end
        resu = @rds.query(sqlu)
    end
end

#fix raw_data error
def fix_raw_data
    sqlu = "select order_id, raw_data from ogoods.pospal_orders where raw_data like '\"{%'"
    res = @rds.query(sqlu)
    res.each do |r|
        oid=r['order_id']
        raw_data = r['raw_data']
        raw_data = raw_data[1..raw_data.length-2] if raw_data[0..1]=='"{'
        sqlu = "UPDATE ogoods.pospal_orders set raw_data='#{raw_data}' where order_id='#{oid}'"
        resu = @rds.query(sqlu)
    end
end

#re-generate statement for order since 2019-07-12
def gen_statement
    sql = "select * from ogoods.pospal_orders where line!='[X]' and order_time >= '2019-07-12'"
    res = @rds.query(sql)
    res.each do |r|
        rationalize_order r
    end
end

gen_statement
