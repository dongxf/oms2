=begin

usage:    将ogoods.pospal_orders中的订单倒入到crmeb中成为完成的历史订单，以便用户追加评论
comment:  目前只构造默认评论,均采用默认订单为0000000

=end
require 'time'
load 'rds_api.rb'

@sales = {}
@parseErrorList = []
@uidNullList = []
@pidNullList = []
@similarCodes = JSON.parse IO.readlines("similar-codes.json")[0] 

def getPospalOrders conditions
  puts "get pospal orders #{conditions}"
  orders = []
  inq = "select order_id, customer_id, date_time, raw_data from ogoods.pospal_orders #{conditions}"
  res = queryRds inq
  res.each do |r|
    begin
      order = JSON.parse r["raw_data"]
      orders += [order]
    rescue => e
      puts ">>>ERROR: #{e}\n   order_id##{r['order_id']} customer_id#{r['customer_id']} date_time##{r['date_time']}"
      @parseErrorList += [r['order_id']]
    end
  end
  puts "done [#{orders.size}]"
  return orders
end

#"INSERT INTO `crmeb`.`eb_store_product_reply`( `uid`, `oid`, `unique`, `product_id`, `reply_type`, `product_score`, `service_score`, `comment`, `pics`, `add_time`, `merchant_reply_content`, `merchant_reply_time`, `is_del`, `is_reply`, `nickname`, `avatar`) VALUES (15, 2, uuid(), 259, 'product', 5, 4, '多个商品也应该是一条评论吧', '', 1541270186, NULL, NULL, 0, 0, '丰巢学锋', 'https://wx.qlogo.cn/mmopen/vi_32/OJ0A9NKqRDDdJF4domd4kVzE4mGUthtibiaiawcuvbAicLHzZ1JXib3kueZWjhiaDzK1p19DxGJclkiaZTD3RHb4jnDrg/132');"
def createCommentsByOrder order
  sqls = []
  print "create comments for order #{order['orderNo']} #{order['orderDateTime']}\r"

  order["items"].each do |item| #TEST
    sqls += createCommentsForItem order, item
  end

  print "done [#{order["items"].size}]                                                                     \r"
  return sqls
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

#对于那些被设为ignored的pospal会员号，寻找一个同openid，但被有效导出的会员号作为替代
def getPrimaryCustomerNumber ignored_number
  inq = "select number, openid from ogoods.pospal_users where openid in ( select openid from ogoods.pospal_users where number = '#{ignored_number}' group by number ) and ignored = 0;"
  res = queryRds inq
  res.each do |r|
    return r['number']
  end
  return nil
end

def getPrimaryUid number
  uid = uidHash[number]
  uid = uidHash[getPrimaryCustomerNumber number] if uid.nil?
  return uid #could still be nil
end

def getPrimaryPid code
  pid = pidHash[code]
  pid = pidHash[@similarCodes[code]] if pid.nil?
  return pid
end

def createCommentsForItem order, item

  print '.'

  uid = getPrimaryUid order['customerNumber']
  pid = getPrimaryPid item['productBarcode']
  order_id = order['orderNo'][0..16]

  if uid.nil? #同一openid多个手机会员号至迁移一个导致，合并到保留会员号处理
    @uidNullList += [order_id]
    puts ">>>ERROR: uid is NULL\n   order_id##{order_id} date##{order['orderDateTime']} number#{order['customerNumber']} code##{order['productBarcode']}"
    return [] 
  else
    print 'o'
  end

  if pid.nil? #pid被删除或修改导致，在没有对应码表之前，同一迁移到pid=1的系统保留商品
    @pidNullList += [order_id]
    pid = 1
  end

  oid = '0000000' #TBD
  avatar = avatarHash[order['customerNumber']]
  nick_name = order['conatactName']
  order_time = order['orderDateTime']
  add_time =  (Time.parse(order_time).to_f * 1000).to_i


  if @sales[pid].nil?
    @sales[pid] = item['productQuantity']
  else
    @sales[pid] += item['productQuantity'] 
  end

  inq = "INSERT INTO `crmeb`.`eb_store_product_reply`( `uid`, `oid`, `unique`, `product_id`, `reply_type`, `product_score`, `service_score`, `comment`, `pics`, `add_time`, `merchant_reply_content`, `merchant_reply_time`, `is_del`, `is_reply`, `nickname`, `avatar`) VALUES (#{uid}, #{oid}, uuid(), #{pid}, 'product', 5, 5, '旧系统迁数据移默认好评，订单主人请在待评价订单中重新评论', '', unix_timestamp('#{order_time}'), NULL, NULL, 0, 0, '#{nick_name}', '#{avatar}');"

  return [inq]
  #queryRds inq

end

def clearAllComments
  return ['delete from crmeb.eb_store_product_reply where 1=1;']
end

def setupTotalSales
  inqs = []
  print "setup total sales\r"
  idx = 0
  @sales.each do |id, sales|
    print '.'
    sql = "update crmeb.eb_store_product set sales = #{sales} where id = #{id};"
    #queryRds sql
    inqs += [sql]
    idx += 1
  end
  print "done [#{idx}]\r"
  return inqs
end

sqls = []
sqls += clearAllComments
orders = getPospalOrders " where line != '[X]';"
orders.each do |order|
  sqls += createCommentsByOrder order
end
sqls += setupTotalSales

File.open("4-import-pospal-comments.sql","w:UTF-8") { |f| f.write sqls.join("\n") }
File.open("3.1-parse-error-list.json","w:UTF-8") { |f| f.write @parseErrorList.to_json } #if @parseErrorList.size > 0
File.open("3.2-uid-null-list.json","w:UTF-8") { |f| f.write @uidNullList.to_json } #if @uidNullList.size > 0
File.open("3.3-pid-null-list.json","w:UTF-8") { |f| f.write @pidNullList.to_json } #if @pidNullList.size > 0
