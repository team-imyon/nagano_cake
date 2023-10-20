class CartItem < ApplicationRecord

  belongs_to :customer
# カート内商品が繋がっているモデルはcustomerのみ

  belongs_to :item
# カート内商品が繋がっているモデルはitemのみ
  
end
