class Address < ApplicationRecord
  
  belongs_to :customer
  # 配送先が繋がっているモデルはcustomerのみ
  
  validates :post_code, presence: true, length: { maximum: 7 }
  validates :address, presence: true
  validates :name, presence: true
end
