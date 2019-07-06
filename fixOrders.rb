#encoding: utf-8
#This ruby file is used to fix unnormal orders, such as cannot pay, cannot ship

require 'mysql2'
require 'json'
require 'awesome_print'

load 'pospal_api.rb'

if !ARGV[0]
        p 'usage: ruby fixOrders.rb condition [--debug]'
        p 'usage: ruby fixOrders.rb condition --complete'
        p 'usage: ruby fixOrders.rb condition --ship'
        p 'eg: ruby fixOrders.rb c=13600060044'
        p 'eg: ruby fxOrders.rb o=19060918234971452'
        p 'eg: ruby fxOrders.rb all'
        return
end

mode = 'debug'
mode = 'complete' if ARGV[1] == '--complete'
mode = 'ship' if ARGV[1] == '--ship'

def get_customer_current_discount rds, order
    customer_id = order['customerNumber']
    sql = "select * from ogoods.pospal_users where number='#{order['customerNumber']}'"
    res = rds.query(sql)
    return res.first['discount'] if res.first
    return 100
end

def get_order_data_by cond
    orders = []
    condition = cond.gsub(/c=/,"customer_id like '%");
    condition = condition.gsub(/o=/,"order_id like '%");
    condition += "%'"
    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])
    sql = "select * from ogoods.pospal_orders where "+condition
    sql = "select * from ogoods.pospal_orders" if cond == 'all'
    res = rds.query(sql)
    res.each do |r|
        raw_data = r['raw_data']
        order = JSON.parse(raw_data)
        order.store('line',r['line'])
        order.store('odate',r['odate'])
        order.store('date',r['date'])
        order.store('number',r['number'])
        customer_discount = get_customer_current_discount rds, order
        order.store('customer_discount',customer_discount)
        orders += [ order ]
    end
    puts "#{orders.size} orders to be fix"
    return orders
end

def pfloat f
    sprintf('%4.2f',f).rjust 7, ' '
end

#本来就不应该给折扣的商品，例如运费
def is_qualified_code code
        return true  if code.include? '01000'
        return false
end

#排除那些第二件商品X折的商品，其中的第一件会按照原价计算
def is_secondary_promotion product_uid, items
    times = 0
    items.each do |item|
        return true if item['productUid'] == product_uid && item['promotionRuleUid']
    end
    return false
end

def format_order order
        customer_discount = order['customer_discount']

        text =  "\n-----------------------------------------------------------------------------------\n"
        text += "order ##{order['orderNo']} on #{order['orderDateTime']} cnumber: #{order['customerNumber']}\n"
        text += "state: #{order['state']} payMethod: #{order['payMethod']} payOnLine: #{order['payOnLine']} payCompleted: #{order['isOnlinePaymentCompleted']} dtype:#{order['deliveryType']} discount: #{customer_discount}\n\n"
        text += "  #{order['contactTel']} #{order['contactName']} #{order['contactAddress']}\n"
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
                code = item['productBarcode']
                if  ( !ipi && !icd && !is_qualified_code(code) && order['line']!='[T]' && !is_secondary_promotion(item['productUid'], items) ) then
                    text += ">#{line}"
                    total_question_price += psp*pq
                    has_question_item = true
                else
                    text += " #{line}"
                end
        end
        amount = order['totalAmount'] #实付
        text += "                                  总计 #{pfloat(total_item_price)}\n"
        text += "                                  运费 #{pfloat(shipping_fee)}\n"
        text += "                                  折让 #{pfloat(total_item_price+shipping_fee-amount)}\n"
        text += "                                  实付 #{pfloat(amount)}\n"
        #积分倒算 (折前商品总价+运费-用户实际支付)*100 #因为信息中并没有用户实际支付，无法计算出来，除非提供按照折扣的估算
        #折扣倒算 (应付总价-未打折商品总价-运费)/打折商品折前总价
        text += "折扣前总标价 #{pfloat(total_list_price)}  不打折总标价 #{pfloat(total_no_discount_price)}  应打折总标价 #{pfloat(total_discount_list_price)} 折后总价 #{pfloat(total_item_price)}\n"
        text += "--------------------------------  #{has_question_item ? 'FOUND' : 'GOOD'}\n"
        #puts text

        order.store('rebate_base',total_question_price)
        order.store('statement',text)
        order.store('has_question_item',has_question_item)

        return order
end

def complete_order order
        puts "completing order..."
        request_body = { 'orderNo' => order['orderNo'] }
        res = pospal_api(:shipOrder, request_body)
        ap res
end

def ship_order order
        p 'ship order'
end

orders = []
orders = get_order_data_by ARGV[0]
total_rebate = 0.0
orders.each do |order|
    ap order if mode == 'debug'
    result = format_order order
    puts result['statement']
    complete_order order if mode == 'complete'
    ship_order if mode == 'ship'
end
