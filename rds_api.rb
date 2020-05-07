require 'mysql2'
require 'json'
require 'awesome_print'

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
