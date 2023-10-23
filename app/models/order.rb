class Order < ApplicationRecord

#payment_methodへenumを定義

enum payment_method: { credit_card: 0, transfer: 1 },status: { waiting: 0, confirmation: 1,　production: 2, preparing: 3, shipped: 4 }

has_many :order_details, dependent: :destroy
# 注文情報は注文商品を沢山持っている


belongs_to :customer
# 注文情報が繋がっているモデルはcustomerのみ


end
