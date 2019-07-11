#encoding: utf-8
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

def get_orders_by_shipdate ship_day
        yesterday = ship_day.prev_day
        s_time = yesterday.strftime('%Y-%m-%d') + ' 14:00:01'
        e_time = ship_day.strftime('%Y-%m-%d') + ' 14:00:00'
        return get_orders_within s_time, e_time
end

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

        begin
                page_count += 1 # to control loop times
                #puts "calling pospal api in #{page_count} time"

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

        rtime = Time.now.strftime('%Y%m%d%H%M%S')
        fn = ".\\auto_import\\porders\\porders-" + s_time.gsub('-','').gsub(':','').gsub(' ','') + '-' + e_time.gsub('-','').gsub(':','').gsub(' ','') + '_' + rtime + ".json"
        File.open(fn,"w:UTF-8") { |f| f.write porders.to_json }
        return porders

end 

def get_order_data_by cond
    printf('getting order data')
    orders = []
    condition = cond.gsub(/c=/,"customer_id like '%");
    condition = condition.gsub(/o=/,"order_id like '%");
    condition += "%'"
    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])
    sql = "select * from ogoods.pospal_orders where line!='[X]' and "+condition
    sql = "select * from ogoods.pospal_orders where line!='[X]'" if cond == 'all'
    res = rds.query(sql)
    res.each do |r|
        print('.')
        raw_data = r['raw_data']
        order = JSON.parse(raw_data)
        order.store('line',r['line'])
        order.store('shipping_fee',r['shipping_fee'])
        order.store('points_used',r['points_used'])
        order.store('order_id',r['order_id'])
        orders += [ order ]
    end
    printf("done\n")
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
            forders += [{
                    :line => decide_route(order),
                    :mark => get_batch_mark(order),
                    :number => get_short_no(order),
                    :zone_code => get_zone_code(order),
                    :short_number => get_short_no(order)[12..16],
                    :date_time => order['orderDateTime'],
                    :short_time => order['orderDateTime'][5..20],
                    :odate => order['orderDateTime'][0..9],
                    :name => get_short_name(order),
                    :addr => get_short_addr(order),
                    :tel => order['contactTel'],
                    :amt => order['totalAmount'],
                    :comment => get_noti(order) + get_short_remark(order),
                    :date => get_short_date(order),
                    :plain_text => get_plain_text(order),
                    :first_item => first_item,
                    :items_count => items_count,
                    :order => order
            }]

        end
        return forders
end

def get_ogoods_orders_by_shipdate ship_day
        yesterday = ship_day.prev_day
        s_time = yesterday.strftime('%Y-%m-%d') + ' 14:00:01'
        e_time = ship_day.strftime('%Y-%m-%d') + ' 14:00:00'
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

        rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])
        sqlu = "select * from ogoods.pospal_orders where order_time >= '#{s_time}' and order_time <= '#{e_time}'"
        resu = rds.query(sqlu)
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
                    :odate => r['odate'],
                    :date => r['date'],
                    :first_item => r['first_item'],
                    :items_count => r['items_count']
            }]

        end
        return oorders
end

#rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1401', :password => ENV['PSI_PASSWORD'])
def update_order_by_json rds, jorder

    order = jorder[:order]

    #convert nil values to zero or ''
    state = order['state'].nil? ? -1 : order['state']
    pay_method = order['payMethod'].nil? ? '' : order['payMethod']
    pay_online = order['payOnLine'].nil? ? -1 : order['payOnLine']
    shipping_fee = order['shippingFee'].nil? ? 0.0 : order['shippingFee']
    zone_code = jorder[:zone_code]
    online_paid = order['isOnlinePaymentCompleted'].nil? ? 0 : order['isOnlinePaymentCompleted']
    amount = order['totalAmount'].nil? ? 0.0 : order['totalAmount']
    delivery_type = order['deliveryType'].nil? ? -1 : order['deliveryType']
    escaped_order_json = order.to_json.gsub("'","''") #用于SQL语句中的转义
    escaped_plain_text = jorder[:plain_text].gsub("'","''")

    sqlu = "INSERT INTO ogoods.pospal_orders
            (
             order_id,state,pay_method,pay_online,online_paid,
             amount,delivery_type,customer_id,shipping_fee,zone_code,
             remark,order_time,name,addr,tel,line,
             mark,number,short_number,date_time,short_time,
             odate,date,
             first_item,items_count,
             print_times,ship_refunded,point_awarded,
             raw_data,plain_text
            ) VALUES (
             '#{jorder[:number]}',#{state},'#{pay_method}',#{pay_online},#{online_paid},
              #{amount},#{delivery_type},'#{order['customerNumber']}',#{shipping_fee},'#{zone_code}',
             '#{order['orderRemark']}','#{order['orderDateTime']}','#{jorder[:name]}','#{jorder[:addr]}','#{jorder[:tel]}','#{jorder[:line]}',
             '#{jorder[:mark]}', '#{jorder[:number]}', '#{jorder[:short_number]}', '#{jorder[:date_time]}', '#{jorder[:short_time]}', 
             '#{jorder[:odate]}', '#{jorder[:date]}', 
             '#{jorder[:first_item]}', #{jorder[:items_count]},
             0,0.0,0.0,
             '#{escaped_order_json}','#{escaped_plain_text}'
            )
            ON DUPLICATE KEY
            UPDATE state=#{state}, pay_method='#{pay_method}', pay_online=#{pay_online}, online_paid=#{online_paid},
            delivery_type=#{delivery_type}, shipping_fee=#{shipping_fee}, zone_code='#{zone_code}',
            line='#{jorder[:line]}',
            mark='#{jorder[:mark]}',number='#{jorder[:number]}',short_number='#{jorder[:short_number]}',
            date_time='#{jorder[:date_time]}',short_time='#{jorder[:short_time]}',
            odate='#{jorder[:odate]}',date='#{jorder[:date]}', 
            first_item='#{jorder[:first_item]}',items_count=#{jorder[:items_count]},
            raw_data='#{escaped_order_json}',plain_text='#{escaped_plain_text}'
    "
    resu = rds.query(sqlu)
end
