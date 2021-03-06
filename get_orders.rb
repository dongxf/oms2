﻿#encoding: utf-8
#this file shows all orders

require 'mysql2'
require 'digest/md5'
require 'net/http'
require 'json'
require 'time'
require 'date'
require 'awesome_print'

load 'router.rb'
load 'pospal_api.rb'
load 'user_api.rb' #to use get_openid_by_number

@rds = Mysql2::Client.new(:host =>ENV['RDS_AGENT'], :username =>"psi_root", :port =>'1401', :password =>ENV['PSI_PASSWORD'], :encoding =>'utf8mb4') if @rds.nil?

def get_orders_by_day someday
        s_time = someday.strftime('%Y-%m-%d') + ' 00:00:00'
        e_time = someday.strftime('%Y-%m-%d') + ' 23:59:59'
        return get_orders_within s_time, e_time
end

# get orders in pospal format, time duration must be within 24hours
def get_pospal_orders_within s_time, e_time

        porders=[]
        page_count = 0
        req={'postBackParameter'=>{}, 'startTime'=> s_time, 'endTime'=> e_time }

        printf "Quering order pages ["
        begin
                page_count += 1 # to control loop times
                printf "."

                res=pospal_api(:queryOrderPages,req)
                recs = res['data']['result']
                recs.each do |rec|
                    porders += [rec]
                end
                actual_size = recs.size
                page_size = res['data']['pageSize']
                req = {'postBackParameter' => res['data']['postBackParameter'], 'startTime'=> s_time, 'endTime'=> e_time }
                #ap res

                break if page_count >= 50 #used for saving api call times in coding pharse

        end while recs.size == page_size
        printf "] Done\n"

        rtime = Time.now.strftime('%Y%m%d%H%M%S')
        fn = ".\\auto_import\\porders\\porders-" + s_time.gsub('-','').gsub(':','').gsub(' ','') + '-' + e_time.gsub('-','').gsub(':','').gsub(' ','') + '_' + rtime + ".json"
        File.open(fn,"w:UTF-8") { |f| f.write porders.to_json }
        return porders

end 

def get_orders_data_by cond

    sql = "select * from ogoods.pospal_orders where line!='[X]' and " + cond + " order by order_time desc"
    orders = get_orders_data_by_sql sql
    return orders
end

def get_orders_data_by_sql sql

    orders = []
    printf 'getting order data[ '

    res = @rds.query(sql)
    res.each do |r|
        printf('.')
        order = {}
        order.store(:need_rebate,r['need_rebate'])
        order.store(:online_paid,r['online_paid'])
        order.store(:line,r['line'])
        order.store(:shipping_fee,r['shipping_fee'])
        order.store(:points_used,r['points_used'])
        order.store(:order_id,r['order_id'])
        order.store(:order_time,r['order_time'])
        order.store(:date_time,r['date_time'])
        order.store(:openid,r['openid'])
        order.store(:uid,r['uid'])
        order.store(:customer_discount,r['customer_discount'])
        order.store(:customer_id,r['customer_id'])
        order.store(:tel,r['tel'])
        order.store(:addr,r['addr'])
        order.store(:statement,r['statement'])
        order.store(:zone_code,r['zone_code'])
        order.store(:amount,r['amount'])
        order.store(:ship_refunded,r['ship_refunded'])
        order.store(:point_awarded,r['point_awarded'])
        order.store(:need_rebate,r['need_rebate'])
        order.store(:rebate_comment,r['rebate_comment'])
        order.store(:comment,r['comment'].nil? ? '' : r['comment'])
        order.store(:notify_history,r['notify_history'])
        order.store(:order_times,r['order_times'])
        order.store(:name,r['name'])
        order.store(:plain_text,r['plain_text'])
        orders += [ order ]
    end

    printf " ]done\n"
    return orders

end

# get tickets form pospal,  time duration must be within 24hours
def get_pospal_tickets_within s_time, e_time

        tickets=[]
        page_count = 0
        req={'postBackParameter'=>{}, 'startTime'=> s_time, 'endTime'=> e_time }

        begin
                page_count += 1 # to control loop times
                #puts "calling pospal api in #{page_count} time"

                res=pospal_api(:queryTicketPages,req)
                recs = res['data']['result']
                recs.each do |rec|
                    tickets += [rec]
                end
                actual_size = recs.size
                page_size = res['data']['pageSize']
                req = {'postBackParameter' => res['data']['postBackParameter'], 'startTime'=> s_time, 'endTime'=> e_time }
                #ap res

                break if page_count >= 50 #used for saving api call times in coding pharse

        end while recs.size == page_size

        rtime = Time.now.strftime('%Y%m%d%H%M%S')
        fn = ".\\auto_import\\tickets\\tickets-" + s_time.gsub('-','').gsub(':','').gsub(' ','') + '-' + e_time.gsub('-','').gsub(':','').gsub(' ','') + '_' + rtime + ".json"
        File.open(fn,"w:UTF-8") { |f| f.write tickets.to_json }
        return tickets

end 

# pospal only support to query orders within 24 hours
def get_orders_within s_time, e_time

        forders=[]

        puts "retrieving orders between #{s_time} and  #{e_time}\n"

        orders = get_pospal_orders_within s_time, e_time

        orders.each do |order|
            slim_addr=get_short_addr order
            slim_name = get_short_name order
            odrmk = "#{get_noti order} #{get_short_remark order}"
            batch_mark =  get_batch_mark order
            short_no = get_short_no order
            items_count = 0
            if !order['items'].nil?
                    order['items'].each do |itm|
                            items_count += itm['productQuantity'].to_i
                    end
            end
            first_item = ''
            first_item = order['items'][0]['productName'] if !order['items'].nil? && !order['items'].empty?
            presale_items = ''
            order['items'].each do |item| 
                if item['productName'].include? '面点预售'
                    presale_items += "#{item['productQuantity']} x #{item['productName']}\n" 
                end
            end
            forder = {
                    :customer_id => order['customerNumber'],
                    :full_order_number => order['orderNo'],
                    :line => decide_route(order),
                    :mark => get_batch_mark(order),
                    :number => get_short_no(order),
                    :short_number => get_short_no(order)[12..16],
                    :zone_code => get_zone_code(order),
                    :date_time => order['orderDateTime'],
                    :short_time => order['orderDateTime'][5..20],
                    :date => order['orderDateTime'][0..9], #duplicated, to be reduced
                    :odate => order['orderDateTime'][0..9],
                    :name => get_short_name(order),
                    :addr => get_short_addr(order),
                    :tel => order['contactTel'],
                    :amount => order['totalAmount'].nil? ? 0.0 : order['totalAmount'], #duplicated, to be reduced
                    :comment => get_noti(order) + get_short_remark(order),
                    :plain_text => get_plain_text(order),
                    :first_item => first_item,
                    :presale_items => presale_items,
                    :items_count => items_count,
                    :state => order['state'].nil? ? -1 : order['state'],
                    :pay_method => order['payMethod'].nil? ? '' : order['payMethod'],
                    :pay_online => order['payOnLine'].nil? ? -1 : order['payOnLine'],
                    :shipping_fee => order['shippingFee'].nil? ? 0.0 : order['shippingFee'],
                    :online_paid => order['isOnlinePaymentCompleted'].nil? ? 0 : order['isOnlinePaymentCompleted'],
                    :delivery_type => order['deliveryType'].nil? ? -1 : order['deliveryType'],
                    :remark => order['orderRemark'],
                    :order => order
            }
            updated_forder = update_order_by_json forder #order_counts, statements will will be updated there

            forders += [updated_forder]

        end
        return forders
end

def get_ogoods_orders_by_shipdate ship_day
        yesterday = ship_day.prev_day
        s_time = yesterday.strftime('%Y-%m-%d') + ' 18:00:01'
        e_time = ship_day.strftime('%Y-%m-%d') + ' 18:00:00'
        return get_ogoods_orders_within s_time, e_time
end

def get_ogoods_orders_by_day someday
        s_time = someday.strftime('%Y-%m-%d') + ' 00:00:00'
        e_time = someday.strftime('%Y-%m-%d') + ' 23:59:59'
        return get_ogoods_orders_within s_time, e_time
end

# pospal only support to query orders within 24 hours
def get_ogoods_orders_within s_time, e_time

        oorders=[]

        puts "retrieving ogoods orders between #{s_time} and  #{e_time}\n"

        sqlu = "select * from ogoods.pospal_orders where order_time >= '#{s_time}' and order_time <= '#{e_time}'"
        resu = @rds.query(sqlu)
        resu.each do |r|
            comment = r['comment'].nil? ? '' : r['comment']
            oorders += [{
                    :order_id => r['order_id'],
                    :state => r['state'],
                    :pay_method => r['pay_method'],
                    :pay_online => r['pay_online'],
                    :online_paid => r['online_paid'],
                    :amount => r['amount'],
                    :delivery_type => r['delivery_type'],
                    :customer_id => r['customer_id'],
                    :uid => r['uid'], #uid有可能为空，需要user_man.rb定时同步过来。不要急于直接从pospal_user查询，因为新用户还是需要同步后才有
                    :openid => r['openid'], #openid有可能为空，需要user_man.rb定时同步过来。不要急于直接从pospal_user查询，因为新用户还是需要同步后才有
                    :shipping_fee => r['shipping_fee'],
                    :remark => r['remark'],
                    :order_time => r['order_time'],
                    :name => r['name'],
                    :addr => r['addr'],
                    :tips => r['tips'],
                    :tel => r['tel'],
                    :line => r['line'],
                    :zone_code => r['zone_code'],
                    :comment => comment,
                    :print_times => r['print_times'],
                    :plain_text => r['plain_text'],
                    :raw_data => r['raw_data'],
                    :ship_refunded => r['ship_refunded'],
                    :point_awarded => r['point_awarded'],
                    :mark => r['mark'],
                    :number => r['number'],
                    :short_number => r['short_number'],
                    :date_time => r['date_time'],
                    :short_time => r['short_time'],
                    :order_times => r['order_times'],
                    :total_times => r['total_times'],
                    :odate => r['odate'],
                    :date => r['date'],
                    :first_item => r['first_item'],
                    :items_count => r['items_count']
            }]

        end
        return oorders
end

def get_userinfo_by_customer_number cn

    sqlu = "select * from ogoods.pospal_users where number='#{cn}'"
    res = @rds.query(sqlu)
    return {:uid => res.first['uid'], :customer_discount => res.first['discount'], :openid =>res.first['openid'] } if res.first

    #if there's no recs, try to get from pospal api and create new rec
    urec = get_urec_by_number_in_pospal cn

    sqlu = "select * from ogoods.pospal_users where number='#{cn}'"
    res = @rds.query(sqlu)
    return {:uid => res.first['uid'], :customer_discount => res.first['discount'], :openid =>res.first['openid'] } if res.first

    #giveup
    return {:uid => '', :customer_discount => 100, :openid => ''}
end

def update_order_by_json jorder

    userinfo = get_userinfo_by_customer_number jorder[:customer_id]
    escaped_order_json = @rds.escape jorder[:order].to_json
    escaped_plain_text = @rds.escape jorder[:plain_text]

    sqlu = "INSERT INTO ogoods.pospal_orders
            (
             order_id,state,pay_method,pay_online,online_paid,
             openid,uid,customer_discount,
             amount,delivery_type,customer_id,shipping_fee,zone_code,
             remark,order_time,name,addr,tel,line,
             mark,number,short_number,date_time,short_time,
             odate,date,
             presale_items,first_item,items_count,
             print_times,ship_refunded,point_awarded,
             raw_data,plain_text
            ) VALUES (
             '#{jorder[:number]}',#{jorder[:state]},'#{jorder[:pay_method]}',#{jorder[:pay_online]},#{jorder[:online_paid]},
             '#{userinfo[:openid]}','#{userinfo[:uid]}',#{userinfo[:customer_discount]},
              #{jorder[:amount]},#{jorder[:delivery_type]},'#{jorder[:customer_id]}',#{jorder[:shipping_fee]},'#{jorder[:zone_code]}',
             '#{jorder[:remark]}','#{jorder[:date_time]}','#{jorder[:name]}','#{jorder[:addr]}','#{jorder[:tel]}','#{jorder[:line]}',
             '#{jorder[:mark]}', '#{jorder[:number]}', '#{jorder[:short_number]}', '#{jorder[:date_time]}', '#{jorder[:short_time]}', 
             '#{jorder[:odate]}', '#{jorder[:date]}', 
             '#{jorder[:presale_items]}','#{jorder[:first_item]}', #{jorder[:items_count]},
             0,0.0,0.0,
             '#{escaped_order_json}','#{escaped_plain_text}'
            )
            ON DUPLICATE KEY
            UPDATE state=#{jorder[:state]}, pay_method='#{jorder[:pay_method]}', pay_online=#{jorder[:pay_online]}, online_paid=#{jorder[:online_paid]},
            openid='#{userinfo[:openid]}', uid='#{userinfo[:uid]}',customer_discount=#{userinfo[:customer_discount]},
            delivery_type=#{jorder[:delivery_type]}, shipping_fee=#{jorder[:shipping_fee]}, zone_code='#{jorder[:zone_code]}',
            line='#{jorder[:line]}',
            mark='#{jorder[:mark]}',number='#{jorder[:number]}',short_number='#{jorder[:short_number]}',
            date_time='#{jorder[:date_time]}',short_time='#{jorder[:short_time]}',
            odate='#{jorder[:odate]}',date='#{jorder[:date]}', 
            presale_items='#{jorder[:presale_items]}',first_item='#{jorder[:first_item]}',items_count=#{jorder[:items_count]},
            raw_data='#{escaped_order_json}',plain_text='#{escaped_plain_text}'
    "
    resu = @rds.query(sqlu)
 
    #update order_counts for this order
=begin
CREATE DEFINER=`psi_root`@`%` PROCEDURE `calcOrderTimes`(IN cid varchar(255))
BEGIN
	declare orderCount int;
	#先将订单次数号全部置为零（取消订单的次数号统一为零）
	update ogoods.pospal_orders set order_times = 0, total_times = 0 where customer_id = cid;
	#获得所有非取消订单的数量
	select count(*) into orderCount from ogoods.pospal_orders where line NOT LIKE '%[X]%' and customer_id = cid;
	# 注意必须用 := 而不是 @i = @i + 1, 否则结果一直为零
	set @i = 0;
	update ogoods.pospal_orders set order_times = ( select @i := @i +1), total_times = orderCount
	where line NOT LIKE '%[X]%' and customer_id = cid ORDER BY order_time;
END
=end
    sql = "call ogoods.calcOrderTimes('#{jorder[:customer_id]}')"
    res = @rds.query(sql)

    #udpate statement and plain text for this order
    sql = "select customer_id, raw_data, customer_discount, points_used, shipping_fee, amount, order_times, total_times, plain_text, tips from ogoods.pospal_orders where line!='[X]' and order_id = '#{jorder[:number]}'"

    res = @rds.query(sql)
    res.each do |r|
        rationalize_order r
        jorder[:order_times] = r['order_times']
        jorder[:total_times] = r['total_times']
        new_str = sprintf(" #%d",r['order_times'])
        eopl = "缺货24小时内原路退款，售后请联系丰巢小蜜18998382701，微信同号\n　　　　foodtrust.cn 让健康和友善随手可及\n"
        if r['order_times'] == 1
            new_str = " !!!!!!!!" 
            eopl = "       【首单提示】感谢选择丰巢有机，和我们一起促进健康和友善！所有的产品禁用化学保鲜及防腐剂，保质期内任何品质问题，请联系丰巢小蜜18998382701，微信同号，不满意无障碍退换\n　　　　　foodtrust.cn 让健康和友善随手可及\n" 
        end
        jorder[:plain_text] = r['plain_text'].gsub('<<<<<<<<<',new_str).gsub('END_OF_PICKUP_LIST',eopl)
        jorder[:plain_text] += "\n#{r['tips']}" if r['tips'] != ''
    end

    return jorder

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

def rationalize_order order

    customer_discount = order['customer_discount']
    points_used = order['points_used'] ? order['points_used'] : 0.0
    shipping_fee = order['shipping_fee'] #if using order['shippingFee'], line T will get nil
    amount = order['amount']

    raw_data = order['raw_data'].gsub("\n","").gsub("\t","")
    begin
      raw_order = JSON.parse raw_data
    rescue Exception => e
      puts e.message
      puts "Exception!! -- #{order['order_id']} --"
      puts raw_data
      return order
    end
    items = raw_order['items']

    order_discount = 1 #后面将在能计算出订单折扣的地方，让icd情况下，最低的item_discount（但不超过customer_discount)作为最新值

    questioned_items_number = 0
    questioned_items_price = 0.0

    text =  "\n-------------------------------------------------\n"
    text += "oid ##{order['order_id']} #{order['order_time']} #{order['line']}\n"
    text += "cid *****" + order['customer_id'][6..12] + "  #{customer_discount}% #{pfloat(points_used)}p  #{pfloat(shipping_fee)}s #{pfloat(amount)}a\n\n"
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

        points_paid = 0.0              #商品积分抵用
        line = ''
        if points_used == 0
            #未使用积分抵扣
            item_discount = icd ? item['customerDiscount']/100 : esp / psp
            order_discount = item_discount if item_discount < order_discount && icd
            points_paid = 0.0
            actual_paid = esp * pq
            subtotal = points_paid + actual_paid
        else
            if amount == 0
                #如果全部是积分支付,因为实付价格都为零，将很难再算出来, 这里采用一个最简单的模拟方法
                #未来或许可根据icd&&ipi商品，以及已知客户折扣准备
                points_paid = psp*pq*points_used/100/psp_sum
                item_discount = points_paid / (psp*pq)
                order_discount = item_discount if item_discount < order_discount && icd
                actual_paid = 0.0
                subtotal = points_paid
            else
                #部分积分支付
                points_paid = points_used/100 * esp_sub / esp_sum
                actual_paid = esp * pq
                subtotal = points_paid + actual_paid
                item_discount = subtotal/(psp*pq)
                order_discount = item_discount if item_discount < order_discount && icd
            end
        end
        subtotal_sum += subtotal

        dmark = item_discount>=0.999 ? '!' : ' '
        line ="#{pfloat(psp)} #{pfloat(pq)} #{pfloat(item_discount)}#{dmark}#{pfloat(points_paid)} #{pfloat(actual_paid)} #{pfloat(subtotal)}    #{pn}\n"

        mark = " "
        if  ( item_discount >0.999 && should_have_discount(item['productBarcode']) && order['line']!='[T]' && !is_secondary_promotion(item['productUid'], items) && customer_discount < 100 ) 
            mark = ">"
            questioned_items_price += psp*pq
            questioned_items_number += 1
        end
        mark = "*" if ipi || is_secondary_promotion(item['productUid'],items)

        text += "#{mark}#{line}"
    end

    text += "\n"
    text += "折前总价 #{pfloat(psp_sum)}                    合计 #{pfloat(subtotal_sum)}\n"
    text += "                                    运费 #{pfloat(shipping_fee)}\n"
    text += "                                    抵扣 #{pfloat(points_used/100)}\n"
    due = subtotal_sum + shipping_fee - points_used/100
    text += "                                    应付 #{pfloat(due)}\n"
    text += "                                    实收 #{pfloat(amount)} #{(due-amount)<0.01&&(amount-due<0.01) ? '   OK' : '   NG'}\n"

    # update order data here
    need_rebate = questioned_items_price * ( 1 - order_discount )
    text += "NEED REBATE:     #{pfloat(need_rebate)}\n" if need_rebate > 0.01

    sqlu = "update ogoods.pospal_orders set 
                need_rebate=#{sprintf('%.2f',need_rebate)}, order_discount=#{sprintf('%.2f',order_discount)},
                statement = '#{text.gsub("'","''")}'
            where order_id = '#{order['order_id']}'"
    @rds.query sqlu

    order.store('order_discount',order_discount)
    order.store('need_rebate',need_rebate)
    order.store('statement',text)
    return order

end
