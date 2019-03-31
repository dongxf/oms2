require 'mysql2'
require 'awesome_print'

rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])

priceHashP = {}; #Price hash in PSI goods_id
priceHashM = {}; #Price hash in Magento code

#prepare price reference table
sql1 = 'select * from psi.t_goods'
res1 = rds.query(sql1)
res1.each do |tgr|
    code = tgr['code']
    id = tgr['id']
    name = tgr['name']
    purchase_price = tgr['purchase_price'];
    priceHashP.store(id,purchase_price);
    priceHashM.store(code,purchase_price);
end

ap priceHashP
