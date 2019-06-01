#encoding: utf-8

#this tool will synced return some useful data records to xxx_man.rb

require 'mysql2'
require 'awesome_print'

def get_uid_by_number_in_ogoods number
        rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'], :encoding => 'utf8mb4' )
        sqlu = "select * from ogoods.pospal_users where number='#{number}'"
        puts sqlu
        res = rds.query(sqlu)
        return res.first['uid'] if res.first
        return nil
end

def get_uid_by_number number
    uid = get_uid_by_number_in_ogoods number
    return uid if uid

    #uid 不存在，需要从pospal单独取，并更新至数据库
end

p get_uid_by_number_in_ogoods '136000600440'
