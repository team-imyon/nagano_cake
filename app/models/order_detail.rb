class OrderDetail < ApplicationRecord
  
  belongs_to :item
  # 注文商品に繋がっているのはitemのみ
  
  belongs_to :order
  # 注文商品に繋がっているのはorderのみ
  
  enum making_status: { cannot_start: 0, waiting: 1, production: 2, completed: 3 }
  
end
