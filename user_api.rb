#encoding: utf-8

# 1) This file provide basic functions to dealing with users

require 'date'
require 'mysql2'
require 'json'
load 'pospal_api.rb'

@rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'], :encoding => 'utf8mb4' ) if @rds.nil?

def get_all_pospal_users 

    pusers=[]
    page_count = 0
    req={'postBackParameter'=>{}}

    begin
        page_count += 1 # to control loop times
        puts "calling pospal api in #{page_count} time"

        res = pospal_api :queryCustomerPages, req
        recs = res['data']['result']
        recs.each do |rec|
            pusers += [rec]
        end

        actual_size = recs.size
        page_size = res['data']['pageSize']
        req = {'postBackParameter' => res['data']['postBackParameter'] }
        #ap res

        break if page_count >= 50 #used for saving api call times in coding pharse

    end while recs.size == page_size

    rtime = Time.now.strftime('%Y-%m-%d-%H%M%S')
    fn = "user-api-" + rtime + ".json"
    File.open(fn,"w:UTF-8") { |f| f.write pusers.to_json }
    fn = "user-api.json"
    File.open(fn,"w:UTF-8") { |f| f.write pusers.to_json }

    puts "done. #{pusers.size}"
    return pusers

end 

#manually update discount for existed recs
def update_discount
    sql = 'select * from ogoods.pospal_users'
    res = @rds.query sql
    res.each do |r|
        next if r['discount']
        uid = r['uid']
        user = JSON.parse(r['raw_data'])
        discount = user['discount']
        sqlu = "update ogoods.pospal_users set discount=#{discount} where uid=#{uid}" 
        @rds.query sqlu
    end
end

def update_userinfo_in_orders
    order_id_list = "(   "
    sqlu = "select order_id from ogoods.pospal_orders where openid is NULL or openid = '' or uid is NULL"
    resu = @rds.query(sqlu)
    resu.each do |r|
        order_id_list += " '#{r['order_id']}',"
    end
    condition = order_id_list[0..order_id_list.size-2]+')'
    return if condition.size < 10 #no order need to update
    sqlu = "UPDATE ogoods.pospal_orders o, ogoods.pospal_users u SET o.uid = u.uid, o.openid = u.openid WHERE o.order_id in #{condition} AND o.customer_id = u.number"
    resu = @rds.query(sqlu)
end

def update_userdb pusers

    ucount=0
    printf "updating userdb ["
    pusers.each do |user|

        raw_data = @rds.escape user.to_json
        uid = user['customerUid']
        number = user['number']
        name = @rds.escape user['name']
        phone = @rds.escape user['phone']
        openid = user['weixinOpenIds'] && user['weixinOpenIds'][0] ? user['weixinOpenIds'][0]['openId'] : '' 
        unionid = user['weixinOpenIds'] && user['weixinOpenIds'][1] ? user['weixinOpenIds'][1]['openId'] : '' 
        discount = user['discount']
        #avatar='https://oss.foodtrust.cn//9c9c2202004250136523040.png' #default avatar, can be updated by aonther programes
        balance = user['balance']
        points = user['point']
        created = user['createdDate']
        address = @rds.escape user['address']

        #p "updating user[#{ucount}] number #{number}..."
        ucount += 1

        #next if ucount<832 #to debug question rec_no 833 debug only 

        sqlu = "INSERT INTO ogoods.pospal_users ( raw_data, uid, number, name, phone, openid, unionid, discount, balance, points, created, address) VALUES 
                        ( '#{raw_data}', '#{uid}', '#{number}', '#{name}', '#{phone}', '#{openid}', '#{unionid}', #{discount}, #{balance}, #{points}, '#{created}' , '#{address}')
                    ON DUPLICATE KEY
                    UPDATE 
				        raw_data = '#{raw_data}', uid = '#{uid}', number = '#{number}', name = '#{name}', phone = '#{phone}', openid = '#{openid}', unionid = '#{unionid}', discount = #{discount}, balance = #{balance}, points = #{points}, created = '#{created}', address = '#{address}'
        "
        begin
            resu = @rds.query(sqlu)
            print('.')
        rescue => e
            puts ">>>ERROR: #{e}"
            puts sqlu 
        end
    end
    printf " ]done\n"

end

def get_uid_by_number_in_ogoods number
    sqlu = "select * from ogoods.pospal_users where number='#{number}'"
    res = @rds.query(sqlu)
    return res.first['uid'] if res.first
    return nil
end

def get_uid_by_number_in_pospal number

    req = { 'customerNum' => number }
    res = pospal_api :queryCustomerUid, req
    rec = res['data']
    update_userdb [rec]
    return rec['customerUid'] #be carefull it's sitll 

end

def get_urec_by_number_in_pospal number
    req = { 'customerNum' => number }
    res = pospal_api :queryCustomerUid, req
    rec = res['data']
    update_userdb [rec]
    return rec
end

def get_uid_by_number number
    uid = get_uid_by_number_in_ogoods number
    return uid if uid
    urec = get_urec_by_number_in_pospal number
    return rec['customerUid']
end

def get_openid_by_number number
    sqlu = "select * from ogoods.pospal_users where number='#{number}'"
    res = @rds.query(sqlu)
    return res.first['openid'] if res.first
    return nil
end

def get_openid_by_uid uid
    sqlu = "select * from ogoods.pospal_users where uid=#{uid}"
    res = @rds.query(sqlu)
    return res.first['openid'] if res.first
    return nil
end

##get_all_pospal_users will generate an json file under .\\auto_import\\, such as puser-20190601123011.json
#pusers = get_all_pospal_users

#pusers=JSON.parse IO.readlines("user-api.json")[0]
#update_userdb pusers

#p get_uid_by_number '136000600440'
