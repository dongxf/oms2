#encoding: utf-8

# 1) This file provide basic functions to get prodct images

require 'date'
require 'mysql2'
require 'json'
load 'pospal_api.rb'

@rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'], :encoding => 'utf8mb4' ) if @rds.nil?

def get_all_pospal_goods

    pospalGoods=[]
    page_count = 0
    req={'postBackParameter'=>{}}

    begin
        page_count += 1 # to control loop times
        puts "calling pospal api in #{page_count} time"

        res = pospal_api :queryProductImagePages, req
        recs = res['data']['result']
        recs.each do |rec|
            pospalGoods += [rec]
        end

        actual_size = recs.size
        page_size = res['data']['pageSize']
        req = {'postBackParameter' => res['data']['postBackParameter'] }
        #ap res

        break if page_count >= 50 #used for saving api call times in coding pharse

    end while recs.size == page_size

    rtime = Time.now.strftime('%Y-%m-%d-%H%M%S')
    fn = ".//export//pospal-goods-" + rtime + ".json"
    File.open(fn,"w:UTF-8") { |f| f.write pospalGoods.to_json }
    fn = ".//export//pospal-goods.json"
    File.open(fn,"w:UTF-8") { |f| f.write pospalGoods.to_json }

    puts "\ndone. #{pospalGoods.size}"
    return pospalGoods

end 

=begin
#generate json file
pospalGoods = get_all_pospal_goods
=end

=begin
pospalGoods=JSON.parse IO.readlines(".//export//pospal-goods.json")[0]
pospalGoods.each do |product|
    puts "#{product['productBarcode']} #{product['productName']} #{product['imageUrl']}"
end
p pospalGoods.count
=end
