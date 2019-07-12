#encoding: utf-8

=begin

This ruby file is use to:
1) find payment and points unmatching issues
2) to generate rebate bonus for those goods missing member discount
3) to generate order discount 
4) to generate hos file ( history order statement )
此文件不应处理实时订单，以免生产的HOS文件重新

=end

require 'mysql2'
require 'json'
require 'find'
require 'awesome_print'
require 'tempfile'

load 'get_orders.rb'

if !ARGV[0]
    p 'usage: ruby hos_man.rb condition [--debug] [--WOS]' #WOS means generate WOS files
    p 'eg: ruby hos_man.rb c=13600060044'
    p 'eg: ruby hos_man.rb o=19060918234971452'
    p 'eg: ruby hos_man.rb d=2019-07-11' #2019-07-11 00:00:00 -  2019-07-11 23:59:59
    p 'eg: ruby hos_man.rb all'           #without today
    p 'eg: ruby hos_man.rb yesterday' # yesterday 00:00:00 -  today 00:00:00
    return
end

wos_mode = false
wos_mode = true if ARGV[1] == '--WOS' || ARGV[2] == '--WOS'

condition = ARGV[0]
case ARGV[0]
when 'all'
    condition = " order_time <= '#{Date.today.strftime('%Y-%m-%d')} 00:00:00' "
when 'yesterday'
    condition = " order_time >= '#{Date.today.prev_day.strftime('%Y-%m-%d')} 00:00:00' and order_time < '#{Date.today.strftime('%Y-%m-%d %H%M')} 00:00:00' "
else
    if condition.include? 'd='
        the_day = Date.parse( condition.split('d=')[1] )
        condition = " order_time >= '#{the_day} 00:00:00' and order_time <= '#{the_day} 23:59:59' " 
    else
        condition = condition.gsub(/c=/,"customer_id like '%");
        condition = condition.gsub(/o=/,"order_id like '%");
        condition += "%'"
    end
end

sql = "select * from ogoods.pospal_orders where line!='[X]' and " + condition + " order by order_time desc"
orders = get_orders_data_by_sql sql

total_need_rebate = 0.0

orders.each do |order|

    printf(".")

    if order['need_rebate'] > 0.01
        total_need_rebate += order['need_rebate']
        printf "x"
    end

    if wos_mode
        printf "-"
        fn = ".\\auto_import\\hos\\H" + order['openid'] + "oS.txt"
        if FileTest::exist? fn
            existed = IO.readlines(fn)
            File.open(fn,"w:UTF-8") do |f| 
                f.puts order['statement'] 
                f.puts existed
            end
        else
            File.open(fn,"a+:UTF-8") { |f| f.write order['statement']}
        end
    end

end
printf("done\n")

puts "total need_rebate: #{sprintf('%.2f',total_need_rebate)}"
