#encoding: utf-8

# 1) This file provide basic functions to dealing with users

require 'date'
require 'mysql2'
require 'json'
load 'pospal_api.rb'

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
        fn = ".\\auto_import\\pusers-" + rtime + ".json"
        File.open(fn,"w:UTF-8") { |f| f.write pusers.to_json }
        return pusers

end 

def update_userdb pusers

        rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'], :encoding => 'utf8mb4' )
        ucount=0
        pusers.each do |user|
            openid=''
            if user['weixinOpenIds']
                openid=user['weixinOpenIds'][0]['openId']
            end
            raw_data=user.to_json.gsub("'","''") 
            number=user['number']
            uname=user['name'].gsub("'","''")
            phone=user['phone'].gsub("'","''")

            p "updating user[#{ucount}] number #{number}..."
            ucount += 1

            #next if ucount<832 #to debug question rec_no 833 debug only 

            sqlu = "INSERT INTO ogoods.pospal_users
                    ( uid,number,name,openid,phone,raw_data) VALUES 
                    ( #{user['customerUid']}, '#{number}','#{uname}','#{openid}', '#{phone}', '#{raw_data}')
                    ON DUPLICATE KEY
                    UPDATE uid=#{user['customerUid']}, number='#{number}',name='#{uname}', openid='#{openid}', phone='#{phone}', raw_data='#{raw_data}'
                   "
            resu = rds.query(sqlu)
        end

end

def get_uid_by_number_in_ogoods number
        rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'], :encoding => 'utf8mb4' )
        sqlu = "select * from ogoods.pospal_users where number='#{number}'"
        res = rds.query(sqlu)
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

def get_uid_by_number number
        uid = get_uid_by_number_in_ogoods number
        return uid if uid

        return get_uid_by_number_in_pospal number
end

##get_all_pospal_users will generate an json file under .\\auto_import\\, such as puser-20190601123011.json
#pusers = get_all_pospal_users
#pusers=JSON.parse IO.readlines(".\\auto_import\\pusers.json")[0]
#update_userdb pusers
#p get_uid_by_number '136000600440'
