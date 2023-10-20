class Address < ApplicationRecord
  
  belongs_to :customer
  # 配送先が繋がっているモデルはcustomerのみ
  
end
