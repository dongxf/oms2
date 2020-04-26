#encoding: utf-8

# 1) This file provide basic functions to get prodct images

require 'date'
require 'mysql2'
require 'json'
load 'pospal_api.rb'

@rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'], :encoding => 'utf8mb4' ) if @rds.nil?

def get_all_pospal_products

    pospal_products=[]
    page_count = 0
    req={'postBackParameter'=>{}}

    begin
        page_count += 1 # to control loop times
        puts "calling pospal api in #{page_count} time"

        res = pospal_api :queryProductImagePages, req
        recs = res['data']['result']
        recs.each do |rec|
            pospal_products += [rec]
        end

        actual_size = recs.size
        page_size = res['data']['pageSize']
        req = {'postBackParameter' => res['data']['postBackParameter'] }
        #ap res

        break if page_count >= 50 #used for saving api call times in coding pharse

    end while recs.size == page_size

    rtime = Time.now.strftime('%Y-%m-%d-%H%M%S')
    fn = ".//export//pospal_products-" + rtime + ".json"
    File.open(fn,"w:UTF-8") { |f| f.write pospal_products.to_json }
    return pospal_products

end 

def update_crmeb_products pospal_products

    ucount=0
    printf "updating userdb ["
    pospal_products.each do |user|
        openid=''
        openid=user['weixinOpenIds'][0]['openId'] if user['weixinOpenIds']
        raw_data=user.to_json.gsub("'","''") 
        number=user['number']
        uname=user['name'].gsub("'","''")
        phone=user['phone'].gsub("'","''")
        printf "."
        discount=user['discount']

        #p "updating user[#{ucount}] number #{number}..."
        ucount += 1

        #next if ucount<832 #to debug question rec_no 833 debug only 

        sqlu = "INSERT INTO ogoods.pospal_users
                    ( uid,number,name,openid,phone,discount,raw_data) VALUES 
                    ( #{user['customerUid']}, '#{number}','#{uname}','#{openid}', '#{phone}', #{discount},'#{raw_data}')
                    ON DUPLICATE KEY
                    UPDATE uid=#{user['customerUid']}, number='#{number}',name='#{uname}', openid='#{openid}', phone='#{phone}', discount=#{discount}, raw_data='#{raw_data}'
        "
        resu = @rds.query(sqlu)
    end
    printf " ]done\n"

end

#generate json file
#pospal_products = get_all_pospal_products

pospal_products=JSON.parse IO.readlines(".//export//pospal-products.json")[0]
pospal_products.each do |product|
    puts "#{product['productBarcode']} #{product['productName']} #{product['imageUrl']}"
end
p pospal_products.count

#update_crmeb_products pospal_products
