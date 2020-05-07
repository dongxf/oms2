#encoding: utf-8

#this tool will synced pospal goods exported data into ogoods db
#user can drag exported file into goods_exported and run this tool manually or automatically by win_cron

load 'goods_api.rb'

#please use '高级搜索' to get all products in pospal '商品资料'panel
overwrite_mode = false
xlsx = "all-pospal-goods.xlsx"

args = ''
ARGV.each { |arg| args+=arg }
xlsx=args if args!='' && args!='-f'
overwrite_mode=true if args=='-f'

puts "updating ogoods.pospal_goods from download excel..."
update_goods = overwrite_mode ?  overwriteOgoodsByExcel(xlsx) : updateOgoodsByExcel(xlsx)
