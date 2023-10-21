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

  ## 消費税を求めるメソッド
  def with_tax_price
      (price * 1.1).floor
  end

  ## 小計を求めるメソッド
  def subtotal
      item.with_tax_price * amount
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/cake.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
