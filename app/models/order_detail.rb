class OrderDetail < ApplicationRecord
  
  belongs_to :item
  # 注文商品に繋がっているのはitemのみ
  
  belongs_to :order
  # 注文商品に繋がっているのはorderのみ
  
  enum making_status: { cannot_start: 0, waiting: 1, production: 2, completed: 3 }
  # enum making_status: { "着手不可":0, "製造待ち":1, "製造中":2, "製造完了":3 }

  def subtotal
    price * amount
  end
  
end
