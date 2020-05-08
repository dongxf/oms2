=begin
用来修正之前处理生成订单时候，因为地址里有换行，未能正确保存的raw_data
=end

require 'json'
require 'awesome_print'

orders = JSON.parse IO.readlines("3.1-parse-error-list.json")[0]
orders.each do |order|
  p order
end
