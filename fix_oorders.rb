#encoding: utf-8
#This ruby file re-calcaluated all first_item and item_counts for all existed recs
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

rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])
sqlu = "select * from ogoods.pospal_orders"
res = rds.query(sqlu)
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
    resu = rds.query(sqlu)
end
