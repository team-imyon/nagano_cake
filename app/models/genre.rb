class Genre < ApplicationRecord
  
  has_many :items, dependent: :destroy
  # 商品ジャンルは沢山の商品情報を持っている。
  
end
