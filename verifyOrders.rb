#encoding: utf-8
#This ruby file is use to find payment and points unmatching issues

require 'mysql2'
require 'json'
require 'awesome_print'

if !ARGV[0]
        p 'usage: ruby verifyOrders.rb condition'
        p 'eg: ruby verifyOrders.rb c=13600060044'
        p 'eg: ruby verifyOrders.rb o=19060918234971452'
        return
end

def get_order_data_by cond
    orders = []
    condition = cond.gsub(/c=/,"customer_id like '%");
    condition = condition.gsub(/o=/,"order_id like '%");
    condition += "%'"
    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])
    sql = "select * from ogoods.pospal_orders where "+condition
    p sql
    res = rds.query(sql)
    res.each do |r|
        next if r['state'] == 3
        raw_data = r['raw_data']
        order = JSON.parse(raw_data)
        order.store('line',r['line'])
        order.store('odate',r['odate'])
        order.store('date',r['date'])
        order.store('number',r['number'])
        orders += [ order ]
    end
    return orders
end

def get_current_customer_discount_by_order order
    customer_id = order['customerNumber']
    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])
    sql = 'select * from ogoods.pospal_users'
    res = rds.query(sql)
    if res.first
            raw_data = res.first['raw_data']
            customer = JSON.parse(raw_data)
            return customer['discount']
    end
    return 100
end

def pfloat f
    sprintf('%4.2f',f).rjust 7, ' '
end

#本来就不应该给折扣的商品，例如运费
def is_qualified_code code
        return true  if code.include? '01000'
        return false
end

def verify_order order
        text =  "\n\n-------------------------------------------------\n"
        text += "order ##{order['orderNo']} on #{order['orderDateTime']} STATE:#{order['state']}\n"
        text += "客户编号：" + order['customerNumber']+"\n\n"
        items = order['items']
        shipping_fee = 0.0
        shipping_fee = order['shippingFee'] if order['shippingFee']
        total_item_price = 0.0
        total_list_price = 0.0
        total_no_discount_price = 0.0
        total_discount_list_price = 0.0
        has_question_item = false
        total_question_price = 0.0
        tlp_cd = 0.0 #所有用了客户折扣的折扣前价格合计
        tsp_uncd = 0.0   #所有没有用客户折扣的商品实际销售价格合计
        text += "  零售价  促销价  折扣   执行价   数量   小计  商品名称\n"
        items.each do |item|
                psp = item['productSellPrice']
                esp = item['eshopSellPrice'] #实际执行价格,通常是把积分扣掉的吧
                icd = item['isCustomerDiscount'] ? item['isCustomerDiscount'] : false #is customer discount
                discount = icd ? item['customerDiscount']/100 : 1.00
                pq = item['productQuantity']
                pn = item['productName']
                ipi = item["promotionRuleUid"] ? true : false #is promotion item
                line =  "#{pfloat psp}"                                            #零售价
                line += " #{ipi ? pfloat(esp) : '       '}"                         #促销价
                line += " #{!ipi&&icd ? '*'+sprintf('%0.2f',discount) : '     ' }"  #折扣
                line += " #{pfloat(esp)}"                                           #执行价格
                line += " #{pfloat(pq)}"                                            #数量
                line += " #{pfloat(esp * pq)}"                                      #小计
                line += " #{pn}\n"                                                  #商品名称
                total_list_price += ipi ?  psp*pq : psp*pq
                total_item_price += esp * pq
                total_no_discount_price += esp * pq if !icd
                total_discount_list_price += psp * pq if icd
                has_question_item = true if !ipi && !icd
                code = item['productBarcode']
                if  ( !ipi && !icd && !is_qualified_code(code) && order['line']!='[T]' ) then
                    text += ">#{line}"
                    total_question_price += esp*pq
                    has_question_item = true
                else
                    text += " #{line}"
                end
        end
        amount = order['totalAmount'] #实付
        due = total_item_price + shipping_fee #应付
        text += " #{pfloat total_list_price}                          合计 #{pfloat(total_item_price)}\n"
        text += "                                  运费 #{pfloat(shipping_fee)}\n"
        text += "                                  应付 #{pfloat(due)}\n"
        text += "                                  实付 #{pfloat(amount)}\n"
        #积分倒算 (商品总价+运费-用户实际支付)*100
        points = ((due - amount )*100).to_i
        text += "                                  积分 #{pfloat(points)}\n"
        #折扣倒算 (实际支付+积分抵扣-未打折商品总价-运费)/打折商品折前总价
        disc = ( amount + points/100 - total_no_discount_price - shipping_fee ) / total_discount_list_price
        text += "                                  折扣 #{pfloat(disc)}\n"
        text += "---------------------------------#{has_question_item ? 'FOUND' : 'GOOD'}\n"
        #puts text

        order.store('points_used',points)
        order.store('discount',disc)
        order.store('rebate_base',total_question_price)
        order.store('statement',text)

        odate = order['orderDateTime'][0..10]
        fn_name = ".\\incoming\\" + ( has_question_item ? 'TORB-' : 'GOOD-' ) + odate + "-order-" + order['line'][1] + '-' + order['orderNo'] + "-c" + order['customerNumber'] + ".txt"
        File.open(fn_name,"w:UTF-8") { |f| f.write text }
        return order
end

orders = []
orders = get_order_data_by ARGV[0]
rebate_base = 0.0
orders.each do |order|
    result = verify_order order
    rebate_base += result['rebate_base']
    puts result['statement'] if result['rebate_base']>0.0
end
puts "total rebate base: #{rebate_base}"
