#encoding: utf-8
=begin

Usage:      This ruby file will recode & split crmeb original order to small orders sort by temp_id
arguments:  ruby code-orders.rb [start_time backward_hours] [-s]'
Example:    ruby code-orders.rb 2019-07-09 08:00 24'

=end

require 'time'
load 'rds_api.rb'

etime = ( ARGV[0] && ARGV[1] ) ? Time.parse("#{ARGV[0]} #{ARGV[1]}") : Time.now
bhours = ARGV[2] ? ARGV[2].to_i : 24
stime = etime - bhours*3600 + 1 #leave one second

#为减少风险，只搜寻有pay_time，也就是已付过款的订单
def get_uncoded_orders_during stime, etime
  orders = []
  inq = "select id, pay_time, order_id, uid, cart_id, shipping_type status, refund_status from crmeb.eb_store_order
     where add_time >= #{stime.to_i} and add_time <= #{etime.to_i} and pay_time is not NULL and order_id not like 'FC%';"
  res = @rds.query inq
  res.each { |order| orders += [order] }
  return orders
end

def recode_able? order
  #只有付过款、未发货、未退款、且未重编码的订单才可以被编码
  return order['pay_time'] && order['status'] ==0 && order['order_id'][0..2] != 'FC4' && order['status'] == 0 && order['refund_status'] != 2
end

def pickup_able? order
  return order['shipping_type'] == 1
end

def split_able? order
  return false
end

def recode_whole_order order
  code = sprintf("FC4%08d",order['id'])
  return queryRds "update crmeb.eb_store_order set order_id = '#{code}' where id = #{order['id']}"
end

#需要在一个事务中锁住，避免对订单重新编码时，用户同时修改
#风险：重编码完成时，用户对旧订单号提交退款或评论，有可能会有问题（待测试取决于是否采用cart id）
def recode_orders orders

  #如果不含多个模版或者是自提订单，直接改编码
  #否则按照订单运费模版编码为不同的订单
  orders.each do |order|
    if recode_able? order
      puts "recoding order #{order['id']}"
      if pickup_able?(order) || split_able?(order)
        #需要
      else
        #简单替换订单编码即可
        recode_whole_order order
      end
    else
      puts ">>>NOTICE: order##{order['id']} should not be coded"
    end
  end
end

orders = get_uncoded_orders_during stime, etime
recode_orders orders
