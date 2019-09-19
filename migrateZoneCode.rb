#This file is used to migrate zone code
#old: ZT, ZB, GD, SW 自提，周边，广东，省外
#new: ZT, ZB, ZPP, ZPG, KD1, KD2, SW, 自提，周边，宅配番禺，宅配广州，I类省内快递上午可发，II类省内只能晚上发，省外快递

require 'date'
require 'time'

load 'get_orders.rb'

@rds = Mysql2::Client.new(:host =>ENV['RDS_AGENT'], :username =>"psi_root", :port =>'1401', :password =>ENV['PSI_PASSWORD'], :encoding =>'utf8mb4') if @rds.nil?

def gen_zone_code order

  addr = order[:addr]

  #到店自提：ZT
  [ '到店自提', '汉溪村'].each { |w| return 'ZT' if addr.include? w }

  #番禺区: ZPP ZPG ZB KD1
  if addr.include? '番禺'
    #宅配P: ZPP
    return 'ZPP' if addr.include?('雅居乐') && !addr.include?('南城')
    return 'ZPP' if addr.include?('顺德') && addr.include?('碧桂园')
      ['星汇文宇','丽江花园','洛浦街道', '百事佳花园', '洛溪南浦锦绣半岛', '丹山新村', '大学城', '前龙西路', '大学小筑', '谷围新村', '小谷围街道', '深井村', '亚运城', '长洲街道', '前锋村', '西城花园' , '兴亚二路' , '清华坊', '市桥'].each { |w| return 'ZPP' if addr.include? w } 
    #宅配G: ZPG
    return 'ZPG' if addr.include?('星河湾半岛') || addr.include?('沙溪')
    #周边小区: ZB
    [ '华碧','华南碧桂园', '欧泊', '红郡' , '华南新城' , '雅居乐', '侨联中学' , '侨朕中学','华南新村' , '锦绣香江' , '星河湾' , '祈福' , '金山谷' , '富豪山庄' ,'南奥','南国奥','汉溪村', '奥园城市天地', '南村时代倾城'].each { |w| return 'ZB' if addr.include? w }
    #其余: KD1
    return 'KD1'
  end


  #广州市：ZPG KD1 KD2
  if addr.include? '广州'
      #例外: KD1
      ['龙洞', '天源路','机务段机山巷','东莞庄路','白云区','黄埔区','萝岗区'].each { |w| return 'KD1' if addr.include? w }
      #边远区域: KD2
      ['南沙','花都','增城','从化'].each { |w| return 'KD2' if addr.include? w }
      #正常: ZPG
      ['天河区','海珠区','越秀区','荔湾区'].each { |w| return 'ZPG' if addr.include? w }
      #其余: KD1
      return 'KD1'
  end

  #东莞及深圳主要区域：KD1
  ['东莞','深圳'].each { |w| return 'KD1' if addr.include? w }

  #其它广东省内: KD2
  ['中山','惠州','江门','珠海','汕头','佛山','湛江','河源', '肇庆','潮州','清远','韶关','揭阳','阳江','云浮','茂名','梅州','汕尾'].each { |w| return 'KD2' if addr.include? w }

  #其余：SW
  return 'SW'

end

def update_zone_code orders
    puts "update zone codes"
    orders.each do |order|
        order_id = order[:order_id]
        old_zc = order[:zone_code]
        new_zc = gen_zone_code order
        if old_zc != new_zc
            puts "#{order_id}: #{old_zc} => #{new_zc}"
            sqlu = "update ogoods.pospal_orders set zone_code='#{new_zc}' where order_id = '#{order_id}'"
            resu = @rds.query(sqlu)
        end
    end
    puts " done"
end

sql = "select * from ogoods.pospal_orders"
orders = get_orders_data_by_sql sql
update_zone_code orders
