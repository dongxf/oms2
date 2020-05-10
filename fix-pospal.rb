=begin

Usage:  用🐟于修正ogoods.pospal_*数据中的错误，以支持迁移到FC4.0

=end

require 'json'
require 'awesome_print'
load 'rds_api.rb'
load 'pospal_api.rb'

@similarCodes={"0110262"=>"0110268","0110147"=>"0182203","0110005"=>"0110246","0110076"=>"0110385","1001036"=>"0000000","0110001-1"=>"0000000","110004"=>"011001
3","9990007"=>"0000000","9990013"=>"0150057","9990008"=>"0000000","110147"=>"0182203","110144"=>"0110144","130075"=>"0000000","150103"=>"0150103","150091"=>"015
0091","110076"=>"0110385","110146"=>"0110146","130079"=>"0000000","180013"=>"0180013","160001"=>"0160001","160009"=>"0000000","110079"=>"0110385","140023"=>"014
0023","130077"=>"0000000","160003"=>"0160003","160011"=>"0160014","150047"=>"0150047","150077"=>"0150077","130082"=>"0000000","150017"=>"0000000","150057"=>"000
0000","150063"=>"0150063","160005"=>"0160005","180014"=>"0180014","160013"=>"0160017","150039"=>"0150039","150065"=>"0150065","150079"=>"0150077","150095"=>"015
0095","160017"=>"0160023","150001"=>"0150001","150007"=>"0150007","150015"=>"0150015","150021"=>"0150021","150013"=>"0150013","150019"=>"0150019","150075"=>"015
0075","150081"=>"0150081","150061"=>"0000000","150067"=>"0000000","1101479"=>"0000000","150099"=>"0150099","1101478"=>"0110158","150055"=>"0150055","150107"=>"0
150109","150109"=>"0150112","150027"=>"0000000","180011"=>"0180011","150073"=>"0150165","150053"=>"0150053","150011"=>"0150011","150105"=>"0150106","150093"=>"0
150093","150101"=>"0150101","150009"=>"0150159","180003"=>"0180003","150043"=>"0150043","150051"=>"0150051","160019"=>"0160026","150069"=>"0000000","1150102"=>"
0150102","160007"=>"0160008","150033"=>"0150033","150087"=>"0150087","1150104"=>"0150104","110005"=>"0110246","180086"=>"0182258","110262"=>"0110281","110282"=>
"0182200"}

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

def getQuestionedGoods fn
  #pospal_orders 中的 order_id
  questionedGoods = {}
  order_ids = JSON.parse IO.readlines(fn)[0] 
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
  return goods
end

def saveQuestionedGoods fn
  goods = getQuestionedGoods fn
  #puts "save_to_excel..."
  #fields = ['old_code', 'name', 'replacement']
  #save_to_excel fields, goods, "code-replacement.xls"
  
  File.open(fn,"w:UTF-8") { |f| f.write goods.to_json }

end

def fix_20200508_III
  saveQuestionedGoods #表交给玉琴去填
end

#运行此函数，输出到txt文件，可以复制到程序中作为已知对应表，运行验证成功后，可以将extened文件覆盖similar-codes.json作为备份
def extend_similar_codes 
  #文件从每次3.3-pid-null-list中得来
  knownSimilarCodes = JSON.parse IO.readlines("similar-codes.json")[0] 
  remained = getQuestionedGoods "3.3-pid-null-list-v3.json"
  toadd = {}
  merged = {}
  remained.each do |r|
    knownSimilarCodes.each do | old, new |
      #puts "#{r['name']} ##{r['old_code']} is found in similarCodes as ##{old}" if old.include?(r['old_code']) || r['old_code'].include?(old)
      toadd.store r['old_code'], new #can't store new key in interation
    end
  end
  knownSimilarCodes.each { |key, value| merged.store key, value.split("\n").join }
  toadd.each { |key, value| merged.store key, value.split("\n").join }
  File.open("similar-codes-extended.json","w:UTF-8") { |f| f.write merged.to_json }
  return merged
end
#ap extend_similar_codes #please save it to txt
