#encoding: utf-8
=begin

Usage:      This ruby file will code & split crmeb original order to small orders sort by temp_id
arguments:  ruby code-orders.rb [start_time backward_hours] [-s]'
Example:    ruby code-orders.rb 2019-07-09 08:00 24'

=end

require 'time'
load 'rds_api.rb'

etime = ( ARGV[0] && ARGV[1] ) ? Time.parse("#{ARGV[0]} #{ARGV[1]}") : Time.now
bhours = ARGV[2] ? ARGV[2].to_i : 24
stime = etime - bhours*3600 + 1 #leave one second

#为减少风险，只搜寻有pay_time的订单
def get_uncoded_orders_during stime, etime
  orders = []
  res = @rds.query "select id from crmeb.eb_store_order where add_time >= #{stime.to_i} and add_time <= #{etime.to_i} and pay_time is not NULL and order_id not like 'FC%';" #using unix_timestamp
  res.each { |order| orders += [order] }
  return orders
end

def is_pickup order
  return false
end

def is_splitable order
  return false
end

#需要在一个事务中锁住，避免对订单重新编码时，用户同时修改
#风险，重编码完成时，用户对旧订单号提交退款或评论，有可能会有问题（取决于是否采用cart id）
def recode_for orders

  #如果不含多个模版或者是自提订单，直接改编码
  #否则按照订单运费模版编码为不同的订单
  orders.each do |order|
    puts "recoding order #{order['id']}"
    if is_pickup(order) || is_splitable(order)
      #需要
    else
      #简单替换订单编码即可
    end
  end
end

orders = get_uncoded_orders_during stime, etime
recode_for orders
