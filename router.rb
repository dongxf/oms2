#encoding 'utf-8'
#This file provide an common method to decide with route should be allocated to specified order
#In the end this should be done in database
require 'time'

def decide_route order

    return '[T]' if order.nil?

    fat_addr = order['contactAddress'].gsub(" ","")
    address=fat_addr.gsub("\u5E7F\u4E1C\u7701\u5E7F\u5DDE\u5E02","\u5E7F\u5DDE")

    return '[T]' if order['state'] != 4
=begin
    if order['state'] = 4
      return '[T]' if pay_online==1 && opay_completed==1
      order_state={0=>'初创建',1=>'已同步',2=>'已发货',3=>'已取消',4=>'已完成'}[order['state']]
      pay_method={'Cash'=>'现金','CustomerBalance'=>'余额','Wxpay'=>'微信','Alipay'=>'支付宝'}[order['payMethod']]
      delivery_type={0=>'自营',1=>'自助',2=>'自提',3=>'预约',4=>'三方'}[order['deliveryType']]
      pay_online={0=>'未用',1=>'通过'}[order['payOnLine']]
      opay_completed={0=>'还未',1=>'已经'}[order['isOnlinePaymentCompleted']]
    end
=end

    return '[Z]' if address.include? '到店自提'
    return '[Z]' if address.include? '汉溪村'

    # if G line worload is too low , otherwise use P line
    return '[G]' if address.include? '欧泊' 
    return '[G]' if address.include? '红郡'
    return '[G]' if address.include? '华南新城'
    return '[G]' if address.include? '雅居乐'

    return '[P]' if address.include? '祈福'
    return '[P]' if address.include? '金山谷'
    return '[P]' if address.include? '富豪山庄'
    return '[P]' if address.include?('雅居乐') && !address.include?('南城')
    return '[P]' if address.include? '清华坊'
    return '[P]' if address.include?('南奥') || address.include?('南国奥')
    return '[P]' if address.include? '锦绣香江'
    return '[P]' if address.include? '华南碧桂园'
    return '[P]' if address.include?('星河湾') && !address.include?('半岛')

    if address.include? '广州'
      #Insert any exception here
      #Exception in Area Name and Road name
      return '[G]' if address.include? '白云路'
      #Exception in PanYu
      return '[G]' if address.include? '星河湾半岛'
      return '[G]' if address.include? '沙溪'

      #normal area
      return '[G]' if address.include? '天河'
      return '[G]' if address.include? '海珠'
      return '[G]' if address.include? '越秀'
      return '[G]' if address.include? '荔湾'
    end

    return '[K]'
 
end
