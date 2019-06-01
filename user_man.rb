#encoding: utf-8

# 1) This file read all users information from pospal and update the database
# 2) Should be used before refund to make sure all CustomerUid is available
#
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

        fn = ".\\auto_import\\pusers.json"
        File.open(fn,"w:UTF-8") { |f| f.write pusers.to_json }
        return pusers

end 

#get_all_pospal_users will generate an json file under .\\auto_import\\, such as puser-20190601123011.json
#pusers = get_all_pospal_users

pusers=JSON.parse IO.readlines(".\\auto_import\\pusers.json")[0]

rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'], :encoding => 'utf8mb4' )
ucount=0
pusers.each do |user|
    openid=''
    if user['weixinOpenIds']
        openid=user['weixinOpenIds'][0]['openId']
    end
    raw_data=user.to_json.gsub("'","''") 
    uname=user['name'].gsub("'","''")

    p "updating user[#{ucount}]..."
    ucount += 1
    next

    #next if ucount<832 #to debug question rec_no 833 debug only 

    sqlu = "INSERT INTO ogoods.pospal_users
            ( uid,number,name,openid,raw_data) VALUES 
            ( #{user['customerUid']}, '#{user['number']}','#{uname}','#{openid}', '#{raw_data}')
            ON DUPLICATE KEY
            UPDATE uid=#{user['customerUid']}, number='#{user['number']}',name='#{uname}', openid='#{openid}', raw_data='#{raw_data}'
           "
    resu = rds.query(sqlu)
end


