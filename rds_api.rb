require 'mysql2'
require 'json'
require 'awesome_print'
require 'spreadsheet' #用于写xls文件
require 'simple-spreadsheet' #用于读取xlsx文件，spreadsheet gem读xlsx会报签名错误

@rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])

def commitTrans inqs
  @rds.query('begin')
    inqs.each do |inq|
      begin
        @rds.query(inq)
      rescue => e
        @rds.query('rollback')
        puts ">>>ERROR: #{e}\n   SQL: #{inq}"
      end
    end
  @rds.query('commit')
end

def queryRds inq
  begin
    return @rds.query(inq)
  rescue => e
    puts ">>>ERROR: #{e}\n   SQL: #{inq}"
    exit
  end
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
