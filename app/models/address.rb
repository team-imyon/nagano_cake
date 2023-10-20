class Address < ApplicationRecord
  
  belongs_to :customer
  # 配送先が繋がっているモデルはcustomerのみ
  
  validates :post_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
end
