class Item < ApplicationRecord
  
  has_one_attached :image
  
  has_many :cart_items, dependent: :destroy
  # 商品情報は沢山のcart_itemsを持っている。
  
  has_many :order_details, dependent: :destroy
  # 商品情報は沢山のorder_details(注文履歴の商品)を持っている。
  
  belongs_to :genre
  # 商品情報に繋がっているのはgenreのみ
  
  has_one_attached :image
  # 画像投稿のためにimageをもたせる
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/cake.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [100, 100]).processed
  end
  
end
