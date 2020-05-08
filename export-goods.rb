#encoding: utf-8

#this tool will export all pospal good into crmeb products

load 'goods_api.rb'

def genProductsSqls
end

overwrite_mode = false
#please use '高级搜索' to get all products in pospal '商品资料'panel
xlsx = "all-pospal-goods.xlsx"

args = ''
ARGV.each { |arg| args+=arg }
xlsx=args if args!='' && args!='-f'
overwrite_mode=true if args=='-f'

=begin

puts "updating ogoods.pospal_goods from download excel..."
update_goods = overwrite_mode ?  overwriteOgoodsByExcel(xlsx) : updateOgoodsByExcel(xlsx)

puts "updating image urls and page contents in pospal_goods according to api..."
#getGoodsImages
updateGoodsAttributes

=end

#generating crmeb db sql cdm
puts "creating crmeb products..."
sqls = createDemoProducts + createCrmebProducts
File.open("2-import-pospal-goods.sql","w:UTF-8") { |f| f.write sqls.join("\n") }

puts "sql statements generated"
#commitTrans sqls #there's performance issue. Please run sql file in naviCat instead. with love.
