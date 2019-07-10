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
    p 'usage: ruby verifyOrders.rb condition [--debug]'
    p 'eg: ruby verifyOrders.rb c=13600060044'
    p 'eg: ruby verifyOrders.rb o=19060918234971452'
    p 'eg: ruby verifyOrders.rb all'
    return
end

@debug_mode=false
@debug_mode=true if ARGV[1]=='--debug'

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
    sql = "select * from ogoods.pospal_orders where line!='[X]' and "+condition
    sql = "select * from ogoods.pospal_orders where line!='[X]'" if cond == 'all'
    res = rds.query(sql)
    res.each do |r|
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
def should_have_discount code
    return false  if code.include? '01000'
    return true
end

#排除那些第二件商品X折的商品，其中的第一件会按照原价计算
def is_secondary_promotion product_uid, items
    times = 0
    items.each do |item|
        return true if item['productUid'] == product_uid && item['promotionRuleUid']
    end
    return false
end

def rationalize_order rds, order

    ap order

    puts "rationalizing order #{order['orderNo']}..."

    items = order['items']
    points_used = order['points_used'] ? order['points_used'] : 0.0
    shipping_fee = order['shippingFee']
    amount = order['totalAmount']
    customer_discount = order['customer_discount']

    questioned_items_number = 0
    questioned_items_price = 0.0

    text =  "\n------------------------------------------------\n"
    text += "cid ##{order['orderNo']} on #{order['orderDateTime']} STATE:#{order['state']}\n"
    text += "oid ******" + order['customerNumber'][6..12]+"  #{customer_discount}% #{pfloat(points_used)}p  #{pfloat(shipping_fee)}s #{pfloat(amount)}a\n\n"
    text += "    标价    数量    折扣    抵扣    实付    小计    品名\n"

    esp_sum = 0.0
    psp_sum = 0.0
    items.each do |item|
        esp_sum += item['eshopSellPrice'] * item['productQuantity']
        psp_sum += item['productSellPrice'] * item['productQuantity']
    end
    subtotal_sum = 0.0

    items.each do |item|

        icd = item['isCustomerDiscount'] ? item['isCustomerDiscount'] : false
        ipi = item["promotionRuleUid"] ? true : false
        pq = item['productQuantity']
        psp = item['productSellPrice'] #商品单位标价
        psp_sub = psp * pq             #商品标价小计
        esp = item['eshopSellPrice']   #分摊积分后实价单价
        esp_sub = esp * pq             #分摊积分后实付小计
        pn = item['productName']       #产品名
        points_paid = 0.0         #商品积分抵用

        line = ''
        if points_used == 0
            item_discount = icd ? item['customerDiscount']/100 : esp / psp
            points_paid = 0.0
            actual_paid = esp * pq
            subtotal = points_paid + actual_paid
        else
            if amount == 0
                #如果全部是积分支付,因为实付价格都为零，将很难再算出来, 这里采用一个最简单的模拟方法
                #未来或许可根据icd&&ipi商品，以及已知客户折扣准备
                points_paid = psp*pq*points_used/100/psp_sum
                item_discount = points_paid / (psp*pq)
                actual_paid = 0.0
                subtotal = points_paid
            else
                #部分积分支付
                points_paid = points_used/100 * esp_sub / esp_sum
                actual_paid = esp * pq
                subtotal = points_paid + actual_paid
                item_discount = subtotal/(psp*pq)
            end
        end
        subtotal_sum += subtotal

        line ="#{pfloat(psp)} #{pfloat(pq)} #{pfloat(item_discount)} #{pfloat(points_paid)} #{pfloat(actual_paid)} #{pfloat(subtotal)}    #{pn}\n"

        if  ( item_discount >0.999 && should_have_discount(item['productBarcode']) && order['line']!='[T]' && !is_secondary_promotion(item['productUid'], items) && customer_discount < 100 ) 
            text += ">#{line}"
            questioned_items_price += psp*pq
            questioned_items_number += 1
        else
            text += " #{line}"
        end
    end
    text += "\n"
    text += "折前总价 #{pfloat(psp_sum)}                    合计 #{pfloat(subtotal_sum)}\n"
    text += "                                    运费 #{pfloat(shipping_fee)}\n"
    text += "                                    抵扣 #{pfloat(points_used/100)}\n"
    due = subtotal_sum + shipping_fee - points_used/100
    text += "                                    应付 #{pfloat(due)}\n"
    text += "                                    实收 #{pfloat(amount)} #{(due-amount)<0.01&&(amount-due<0.01) ? '   OK' : '   NG'}\n"

    # or update order data here
    order.store('questioned_items_price',questioned_items_price)
    order.store('questioned_items_number',questioned_items_number)
    
    puts text if @debug_mode
    return order
end

orders = []
orders = get_order_data_by ARGV[0]
total_need_rebate = 0.0
rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])

orders.each do |order|
    rationalize_order rds, order
end

puts "total need_rebate: #{sprintf('%.2f',total_need_rebate)}"
