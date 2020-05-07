=begin

usage:    将ogoods.pospal_orders中的订单倒入到crmeb中成为完成的历史订单，以便用户追加评论
comment:  目前只构造默认评论,均采用默认订单为0000000

=end
require 'time'
load 'rds_api.rb'

@sales = {}

def getPospalOrders conditions
  puts "get pospal orders #{conditions}"
  orders = []
  inq = "select order_id, raw_data from ogoods.pospal_orders #{conditions}"
  res = queryRds inq
  res.each do |r|
    begin
      order = JSON.parse r["raw_data"]
      orders += [order]
    rescue => e
      puts ">>>ERROR: #{e}\n   order_id: #{r['order_id']}"
    end
  end
  puts "done [#{orders.size}]"
  return orders
end

#"INSERT INTO `crmeb`.`eb_store_product_reply`( `uid`, `oid`, `unique`, `product_id`, `reply_type`, `product_score`, `service_score`, `comment`, `pics`, `add_time`, `merchant_reply_content`, `merchant_reply_time`, `is_del`, `is_reply`, `nickname`, `avatar`) VALUES (15, 2, uuid(), 259, 'product', 5, 4, '多个商品也应该是一条评论吧', '', 1541270186, NULL, NULL, 0, 0, '丰巢学锋', 'https://wx.qlogo.cn/mmopen/vi_32/OJ0A9NKqRDDdJF4domd4kVzE4mGUthtibiaiawcuvbAicLHzZ1JXib3kueZWjhiaDzK1p19DxGJclkiaZTD3RHb4jnDrg/132');"
def createCommentsByOrder order
  puts "create comments for order #{order['orderNo']} #{order['orderDateTime']}"

  order["items"][0..1].each do |item| #TEST
    createCommentsForItem order, item
  end

  puts "done [#{order["items"].size}]"
end

def uidHash
  @uids = getUidHash if @uids.nil?
  return @uids
end

#通过POSPAL用户会员号找系统用户号
def getUidHash
  uids = {}
  inq = "select pospal_number, uid from crmeb.eb_user where pospal_number is not NULL"
  res = queryRds inq
  res.each { |r| uids.store(r['pospal_number'],r['uid']) }
  return uids
end

def pidHash
  @pids = getPidHash if @pids.nil?
  return @pids
end

def getPidHash
  pids = {}
  inq = "select pospal_code, id from crmeb.eb_store_product where pospal_code is not NULL"
  res = queryRds inq
  res.each { |r| pids.store(r['pospal_code'],r['id']) }
  return pids
end

def avatarHash
  @avatars = getAvatarHash if @avatars.nil?
  return @avatars
end

def getAvatarHash
  avatars = {}
  inq = "select pospal_number, avatar from crmeb.eb_user where pospal_number is not NULL"
  res = queryRds inq
  res.each { |r| avatars.store(r['pospal_number'],r['avatar']) }
  return avatars
end


def createCommentsForItem order, item

  print '.'

  uid = uidHash[order['customerNumber']]
  return if uid.nil? #已不存在
  avatar = avatarHash[order['customerNumber']]
  oid = '0000000' #TBD
  pid = pidHash[item['productBarcode']]
  return if pid.nil? #已经不存在的商品
  nick_name = order['conatactName']
  order_time = order['orderDateTime']
  add_time =  (Time.parse(order_time).to_f * 1000).to_i

  if @sales[item['productBarcode']].nil?
    @sales[item['productBarcode']] = item['productQuantity']
  else
    @sales[item['productBarcode']] += item['productQuantity'] 
  end

  sql = "INSERT INTO `crmeb`.`eb_store_product_reply`( `uid`, `oid`, `unique`, `product_id`, `reply_type`, `product_score`, `service_score`, `comment`, `pics`, `add_time`, `merchant_reply_content`, `merchant_reply_time`, `is_del`, `is_reply`, `nickname`, `avatar`) VALUES (#{uid}, #{oid}, uuid(), #{pid}, 'product', 5, 5, '旧系统迁数据移默认好评，订单主人请在待评价订单中重新评论', '', unix_timestamp('#{order_time}'), NULL, NULL, 0, 0, '#{nick_name}', '#{avatar}');"
  queryRds sql

end

def clearAllComments
  sql = 'delete from crmeb.eb_store_product_reply where 1=1'
  queryRds sql
end

def setupTotalSales
  puts "setup total sales"
  idx = 0
  @sales.each do |code, sales|
    print '.'
    sql = "update crmeb.eb_store_product set sales = #{sales} where pospal_code = '#{code}';"
    queryRds sql
    idx += 1
  end
  puts "done [#{idx}]"
end

clearAllComments
orders = getPospalOrders " where line != '[X]';"
orders.each do |order|
  createCommentsByOrder order
end
setupTotalSales
