#encoding: utf-8

=begin

This ruby file is use to:
1) find payment and points unmatching issues
2) to generate rebate bonus for those goods missing member discount
3) to generate order discount 
3) to generate a order statement for customer

=end

require 'mysql2'
require 'json'
require 'awesome_print'

if !ARGV[0]
    p 'usage: ruby verifyOrders.rb condition'
    p 'eg: ruby verifyOrders.rb c=13600060044'
    p 'eg: ruby verifyOrders.rb o=19060918234971452'
    p 'eg: ruby verifyOrders.rb all'
    return
end

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
        next if r['line'] == '[X]' #取消的订单一般就不搞了
        raw_data = r['raw_data']
        order = JSON.parse(raw_data)
        order.store('line',r['line'])
        order.store('odate',r['odate'])
        order.store('date',r['date'])
        order.store('number',r['number'])
        order.store('points_used',r['points_used'])
        customer_discount = get_customer_current_discount rds, order
        order.store('customer_discount',customer_discount)
        orders += [ order ]
    end
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

def verify_order order
    customer_discount = order['customer_discount']
    if customer_discount == 100 #对于百花蜜无需核算
        order.store('rebate_base',0.0)
        return order
    end

    text =  "\n-------------------------------------------------\n"
    text += "order ##{order['orderNo']} on #{order['orderDateTime']} STATE:#{order['state']}\n"
    text += "客户编号：" + order['customerNumber']+"\n\n"
    items = order['items']
    points_used = 0.0
    points_used = order['points_used'] if order['points_used']
    shipping_fee = 0.0
    shipping_fee = order['shippingFee'] if order['shippingFee']
    total_item_price = 0.0
    total_list_price = 0.0
    total_no_discount_price = 0.0
    total_discount_list_price = 0.0
    has_question_item = false
    total_question_price = 0.0
    text += "  零售价  促销价  折扣   执行价   数量   小计  商品名称\n"
    items.each do |item|
        psp = item['productSellPrice']
        esp = item['eshopSellPrice'] #实际执行价格,通常是把积分扣掉的吧
        icd = item['isCustomerDiscount'] ? item['isCustomerDiscount'] : false #is customer discount
        discount = icd ? item['customerDiscount']/100 : 1.00
        pq = item['productQuantity']
        pn = item['productName']
        ipi = item["promotionRuleUid"] ? true : false #is promotion item
        line =  "#{pfloat psp}"                                             #零售价
        line += " #{ipi ? pfloat(esp) : '       '}"                         #促销价
        line += " #{!ipi&&icd ? '*'+sprintf('%0.2f',discount) : '     ' }"  #折扣
        line += " #{pfloat(esp)}"                                           #执行价格
        line += " #{pfloat(pq)}"                                            #数量
        line += " #{pfloat(esp * pq)}"                                      #小计
        line += " #{pn}\n"                                                  #商品名称
        total_list_price += ipi ?  esp*pq : psp*pq
        total_item_price += esp * pq
        total_no_discount_price += ( ipi ? esp : psp ) * pq if !icd
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
    text += "                                  总计 #{pfloat(total_item_price+points_used/100)}\n"
    text += "                                  运费 #{pfloat(shipping_fee)}\n"
    text += "                              积分抵扣 #{pfloat(points_used/100)}\n"
    due = total_item_price + shipping_fee       #应付
    text += "                                  实付 #{pfloat(amount)}\n"
    #积分倒算 (折前商品总价+运费-用户实际支付)*100 #因为信息中并没有用户实际支付，无法计算出来，除非提供按照折扣的估算
    #折扣倒算 (实付+积分支付-运费-未打折商品总价)/打折商品折前总价
    order_discount = 1.0 if order['line'] == '[T]'
    order_discount = (amount+points_used/100-shipping_fee-total_no_discount_price)/total_discount_list_price
    order_discount = order['customer_discount'] if order_discount.nan? || order_discount.infinite?  #当只有一种不打会员折扣的商品时,order_discount会得到NaN
    puts "****#{order_discount}***"
    text += "                              本单折扣 #{pfloat(order_discount)}\n"
    text += "折扣前总标价 #{pfloat(total_list_price)}  不打折总标价 #{pfloat(total_no_discount_price)}  应打折总标价 #{pfloat(total_discount_list_price)} 折后总价 #{pfloat(total_item_price)}\n"
    text += "----------------------------- #{has_question_item ? 'FOUND' : 'GOOD'}\n"

    order.store('rebate_base',0.0)
    order.store('need_rebate',0.0)
    if has_question_item 
        text += "list_price: #{total_question_price} order_discount: #{pfloat(order_discount)} need_rebate: #{pfloat(total_question_price * (1-order_discount))}\n"
        order.store('rebate_base',total_question_price)
        order.store('need_rebate',total_question_price*(1-order_discount))
    end

    order.store('has_question_item',has_question_item)
    order.store('order_discount',order_discount)

    order.store('order_details',text)

    return order
end

def save_patched_order rds, order

    text =  "\n-----------------------------------------------------------\n"
    text += "order ##{order['orderNo']} on #{order['orderDateTime']} STATE:#{order['state']}\n"
    text += "客户编号：******" + order['customerNumber'][6..11]+"\n\n"
    items = order['items']
    points_used = 0.0
    points_used = order['points_used'] if order['points_used']
    shipping_fee = 0.0
    shipping_fee = order['shippingFee'] if order['shippingFee']
    order_discount = 1
    order_discount = order['order_discount'] if order['order_discount']
    total_item_price = 0.0
    text += "  零售价  促销价  折扣   执行价   数量   小计  商品名称\n"
    amount = order['totalAmount'] #实付
    questioned_items = 0
    items.each do |item|
        psp = item['productSellPrice']
        esp = item['eshopSellPrice'] #实际执行价格,通常是把积分扣掉的吧
        icd = item['isCustomerDiscount'] ? item['isCustomerDiscount'] : false #is customer discount
        ipi = item["promotionRuleUid"] ? true : false #is promotion item
        pq = item['productQuantity']
        pn = item['productName']
        item_actual_price = esp
        item_actual_price = esp if ipi
        item_actual_price = psp * order_discount if icd
        item_subtotal = item_actual_price * pq
        line =  "#{pfloat psp}"                                             #零售价
        line += " #{ipi ? pfloat(esp) : '       '}"                         #促销价
        line += " #{!ipi&&icd ? '*'+sprintf('%0.2f',order_discount) : '     ' }"  #折扣
        line += " #{pfloat(esp)}" if ipi                                    #执行价格
        line += " #{pfloat(item_actual_price)}" if !ipi                     #执行价格
        line += " #{pfloat(pq)}"                                            #数量
        line += " #{pfloat(item_subtotal)}"                                 #小计
        line += " #{pn}\n"                                                  #商品名称
        total_item_price += item_subtotal
        code = item['productBarcode']
        if  ( !ipi && !icd && !is_qualified_code(code) && order['line']!='[T]' && !is_secondary_promotion(item['productUid'], items) ) then
            text += ">#{line}"
            questioned_items += 1
        else
            text += " #{line}"
        end
    end
    text += "                                  总计 #{pfloat(total_item_price)}\n"
    text += "                                  运费 #{pfloat(shipping_fee)}\n"
    text += "                              积分抵扣 #{pfloat(points_used/100)}\n"
    due = total_item_price + shipping_fee       #应付
    text += "                                  实付 #{pfloat(amount)}\n"
    text += "                              本单折扣 #{pfloat(order_discount)}\n"
    if questioned_items > 0
        text += "- FOUND #{questioned_items} questioned items\n"
        text += "  price to rebate : #{order['rebate_base']}\n"
        text += "  order discount  : #{pfloat(order['order_discount'])}\n"
        text += "  points to rebate: #{pfloat(order['need_rebate']*100)}\n"
    else
        text += "- GOOD\n"
    end
    order.store('statement',text)
    puts text

    sqlu = "UPDATE ogoods.pospal_orders set
                order_discount=#{sprintf('%.2f',order['order_discount'])}, need_rebate=#{sprintf('%.2f',order['need_rebate']*100)},
                statement='#{text.gsub("'","''")}'
            WHERE order_id='#{order['orderNo'][0..16]}'
    "
    puts sqlu
    rds.query sqlu
    return order
end

orders = []
orders = get_order_data_by ARGV[0]
total_need_rebate = 0.0
rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])

orders.each do |order|
    patched_order = verify_order order
    save_patched_order rds, patched_order
    next if patched_order['need_rebate']==0.0
    total_need_rebate += patched_order['need_rebate']
end

puts "total need_rebate in points: #{sprintf('%.2f',total_need_rebate*100)}"
