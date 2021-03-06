#encoding: utf-8

=begin
    Name: Qualified reviewers generator
    Usage: ruby qr_gen.rb 012003
    Description: 用于根据特定的商品号生成可以评论的用户标识，提供给评论奖励程序(award_man.rb)使用
    Comments:

    * qualified_reviewers
    goods_code, openid, avatar, nick_name, phone, last_buy_date, order_id, buy_times, points_awarded, points_transfered

	* 系统生成数据时，最后两数据默认为零，在award_man.rb发放积分时奖励
	* 首先是M系统根据相应产品的product_entity_id直接用goods_id写入数据
	* 再在pospal_order中检查，如果已存在该goods_id和openid的组合，则更新最新的last_purchased_date，以及购买次数组合

    * 之后每做一个产品，手工往里面增加一次。。。直到可以批量的时候
    * 批量预生成magento数据迁移的方法： 建立goods_id与product_entity_ids对应表，已经有goods_id的忘记
=end

require 'pg'
require 'mysql2'
require 'awesome_print'

def ms_test
    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1402', :password => ENV['PSI_PASSWORD'])
    sql = 'select * from ogoods.wechat_fans'
    res = rds.query(sql)
    res.each { |r| p r['nick_name'] }
end

def pg_test
    connect = PG::connect(host: 'rdsagent.foodtrust.cn', user: "postgres", password: ENV['PSI_PASSWORD'], dbname: "commento", port: "1403" )
    results = connect.exec("select * from comments")
    results.each{|result| p result["commenterhex"] }
    connect.finish
end

def create_qualified_reviewers_table

        rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1402', :password => ENV['PSI_PASSWORD'])

        sql = 'DROP TABLE IF EXISTS ogoods.qualified_reviewers;'
        res = rds.query(sql)

        sql = ' CREATE TABLE ogoods.qualified_reviewers  (
          `goods_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
          `product_entity_id` int(11) NULL DEFAULT 0,
          `openid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
          `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
          `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
          `phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
          `last_buy_date` datetime(6) NULL DEFAULT NULL,
          `order_no` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
          `buy_times` int(11) NULL DEFAULT 0,
          `points_awarded` decimal(11, 2) NULL DEFAULT 0,
          `points_transfered` decimal(11, 2) NULL DEFAULT 0
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;'
        res = rds.query(sql)

end

=begin
          
=end
def update_qualified_reviwers customerList

end

#generate an Array
#productId是在M系统中的Product_Entity_ID, goodsCode是对应在银豹系统中的商品编码
def gen_customer_list_by_product_entity_id productId, goodsCode

    list = []
    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1402', :password => ENV['PSI_PASSWORD'])

    sql = "select o.customer_id as customer_id, o.phone as phone, o.increment_id as order_no, o.created_at as created_at 
    from foodtrust.sales_flat_order_item as oitem
        left join foodtrust.sales_flat_order as o 
        on o.entity_id= oitem.order_id
        where oitem.order_id > 0 and oitem.product_id=#{productId} and o.customer_id>0 and (o.status in('processing','complete')) 
        group by customer_id order by max(order_id) desc limit 0,1000;"
    res = rds.query(sql)
    res.each do |r|
            list += [ { product_id: productId, goods_code: goodsCode, customer_id: r['customer_id'], phone: r['phone'], order_no: r['order_no'], order_date: r['created_at'] } ]
    end
    return list
end

#to generate an Hash with includ customer information hash
def extend_customer_list list
    rds = Mysql2::Client.new(:host => ENV['RDS_AGENT'], :username => "psi_root", :port => '1402', :password => ENV['PSI_PASSWORD'])
    extendedList = []
    list.each do |customer|
            customer_entity_id = customer[:customer_id]
            sql = " select m.entity_id as customer_id, at.value as avatar, m.email as email, la.value as lastname, cg.customer_group_code as groupname
                from foodtrust.customer_entity_varchar as at
                left join foodtrust.customer_entity as m
                on m.entity_id = at.entity_id
                left join foodtrust.customer_group as cg
                on m.group_id = cg.customer_group_id
                left join foodtrust.customer_entity_varchar as la
                on la.entity_id = at.entity_id and la.attribute_id = 5
                where at.attribute_id= 318 and at.entity_id = #{customer_entity_id}"

            res = rds.query(sql)
            existed = customer
            res.each do |r|
                customer_id = r['customer_id']
                openid = r['email'].gsub('@weixin.com','')
                avatar = r['avatar']

                existed.store(:openid, openid)
                existed.store(:avatar, avatar)
            end
            extendedList += [ existed ]
    end
    ap extendedList
    return extendedList
end

#初始化数据表，仅运行一次
create_qualified_reviewers_table #ONLY use for initialize table

#获得对应Magento某产品的用户信息表,可能有重复数据
customerList = []
customerList += gen_customer_list_by_product_entity_id(4312,'0120036')
customerList += gen_customer_list_by_product_entity_id(4313,'0120036')
customerList += gen_customer_list_by_product_entity_id(4314,'0120036')
#customerList.each { |customer| puts "#{customer[:customer_id]} #{customer[:order_no]}" }

#为已有的客户列表扩张属性，例如openid, avatar
extendedCustomerList = extend_customer_list customerList
ap extendedCustomerList

update_qualified_reviwers extendedCustomerList
