class Genre < ApplicationRecord
  # 商品ジャンルは沢山の商品情報を持っている。
  has_many :items, dependent: :destroy

  validates :name, presence: true

end
