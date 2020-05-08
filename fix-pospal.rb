=begin

Usage:  用🐟于修正ogoods.pospal_*数据中的错误，以支持迁移到FC4.0

=end

require 'json'
require 'awesome_print'
load 'rds_api.rb'
load 'pospal_api.rb'

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

#得到原生订单号
def getOrderNumbers order_ids
  orderNumbers = []
  order_ids.each do |oid|
    orderNumbers +=  ["#{oid}104"]
  end
  return orderNumbers
end

# 用来修正之前处理生成订单时候，地址中换行未能正确通过@rds.esacpe转换保存的raw_data
# 需要修正的订单编号列表从export-orders中遇到parse raw_data错误时得到
# 修正后再运行export-orders则不再遇到类似错误
def fix_20200508_I
  #pospal_orders 中的 order_id
  order_ids = JSON.parse IO.readlines("3.1-parse-error-list-v1.json")[0] 
  order_numbers = getOrderNumbers order_ids #得到原生订单号

  order_ids.size.times do |idx|

    puts "#{order_ids[idx]} #{order_numbers[idx]}"
    req = { "orderNo": order_numbers[idx] }
    res = pospal_api :queryOrderByNo, req

    inq = "update ogoods.pospal_orders set raw_data = '#{@rds.escape res["data"].to_json}' where order_id = '#{order_ids[idx]}';"
    queryRds inq

  end
end
#fix_20200508_I #done

# 探索一下3.2 uid为空的订单, 200多个
# 实际是同一openid下的多个会员号，已根据唯一原则，并入未ignored的唯一账户，不再出错
def fix_20200508_II
  #pospal_orders 中的 order_id
  order_ids = JSON.parse IO.readlines("3.2-uid-null-list-v1.json")[0] 
  order_numbers = getOrderNumbers order_ids #得到原生订单号
  order_ids.size.times do |idx|
    puts "#{order_ids[idx]} #{order_numbers[idx]}"
  end
  puts order_ids.size
end
#fix_20200508_II

# 探索一下3.3 pid为空的订单, 600多个，基本都是19年9月之前的
# 感觉有可能改动goods_code导致的问题？

def getSimilarNameProductCode name, code

  knownList = { 
    '0110262' => '0110268',
    '0110147' => '0182203',
    '0110076' => '0110075',
    '0110005' => '0110246',
    '0110076' => '0110385'
  }

  return knownList[code] if !knownList[code].nil?
  
  match = name[0..(name.length*1/2).to_i]
  inq = "select name, code from ogoods.pospal_goods where name like '%#{match}%' and code != '#{code}';"
  res = queryRds inq
  res.each do |r| 
    return r['code'] 
  end #return first similar products
  puts "No similar: #{name} #{code} | #{match}"
  puts "  SQL: #{inq}"
  return nil
end

def getQuestionedGoods
  #pospal_orders 中的 order_id
  questionedGoods = {}
  order_ids = JSON.parse IO.readlines("3.3-pid-null-list-v1.json")[0] 
  order_numbers = getOrderNumbers order_ids #得到原生订单号
  order_ids.size.times do |idx|
    #puts "#{order_ids[idx]} #{order_numbers[idx]}"
    #next if idx != 93 #random check
    inq = "select raw_data from ogoods.pospal_orders where order_id = '#{order_ids[idx]}';"
    res = queryRds inq
    res.each do |r|
      data = r['raw_data']
      order = JSON.parse data
      order["items"].each do |item|
        pid = pidHash[item['productBarcode']]
        if pid.nil?
          questionedGoods.store item['productBarcode'], item['productName']
        end
      end
    end
  end
  goods = []
  questionedGoods.each do |code, name|
    goods += [{'old_code' => code, 'name' => name, 'replacement' => ''}]
  end
  ap goods
  return goods
end

def saveQuestionedGoods
  goods = getQuestionedGoods
  puts "save_to_excel..."
  fields = ['old_code', 'name', 'replacement']
  save_to_excel fields, goods, "code-replacement.xls"
end

#TBD
def fix_20200508_III
  saveQuestionedGoods #表交给玉琴去填
end


