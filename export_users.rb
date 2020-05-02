#encoding: utf-8

#this tool will export pospal_users into crmeb

require 'mysql2'
require 'json'
require 'awesome_print'
require 'spreadsheet' #用于写xls文件
require 'simple-spreadsheet' #用于读取xlsx文件，spreadsheet gem读xlsx会报签名错误

@rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])

def read_pospal_users

    recs = []

    inq = "select * from ogoods.pospal_users"
    res = @rds.query(inq)

    res.each do | r |
        rec = {}
        #basic fields
        fields = ['uid','number','name','phone','openid','discount','raw_data']
        fields.each { |f| rec[f]=r[f] }

        #raw_data fields
        keys = ['point','discount','balance','address','createdDate']
        json = JSON.parse r['raw_data']
        keys.each do |k|  #raw_data

            rec[k]=json[k]

            #check unionid and openid again
            rec['unionid']=''
            if json['weixinOpenIds']
                if json['weixinOpenIds'][0]
                    rec['openid'] = json['weixinOpenIds'][0]['openId'] 
                end
                rec['unionid'] = json['weixinOpenIds'][1]['openId'] if json['weixinOpenIds'][1]
            end

        end

        #ap rec if rec['phone'].include? '136000600'  #just check
        recs += [rec]
    end

    puts "done. #{recs.size}"
    return recs
end

def save_to_excel names, items, fn

    Spreadsheet.client_encoding="utf-8"
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet :name => "sheet"

    #生成表头
    colIndex=0 #col index
    names.each do |name|
        sheet.row(0)[colIndex]=name
        colIndex += 1
    end

    lineIndex = 1
    items.each do |item|
        colIndex=0
        names.each do |name|
            sheet.row(lineIndex)[colIndex] = item[name]
            colIndex +=1
        end
        lineIndex += 1
    end

    book.write fn
    puts "done. #{items.size}"
end

puts "reading all recs from pospal..."
recs = read_pospal_users
names = ['uid','number','name','phone','openid','unionid','discount', 'point','balance','address','createdDate']

puts "writing excel file..."
save_to_excel names, recs, './export/pospal-users-all.xls'
