class CartItem < ApplicationRecord

  belongs_to :customer
# カート内商品が繋がっているモデルはcustomerのみ

  belongs_to :item
# カート内商品が繋がっているモデルはitemのみ

# validates :amount, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 50 }

  # 小計を求めるメソッド
  def subtotal
      item.with_tax_price * amount
  end

end
