class CartItem < ApplicationRecord

  belongs_to :customer
# カート内商品が繋がっているモデルはcustomerのみ

  belongs_to :item
# カート内商品が繋がっているモデルはitemのみ

  # 小計を求めるメソッド
  def subtotal
      item.with_tax_price * amount
  end
  
end
