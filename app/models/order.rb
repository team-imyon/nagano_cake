class Order < ApplicationRecord

#payment_methodへenumを定義

enum payment_method: { credit_card: 0, transfer: 1 },status: { waiting: 0, confirmation: 1,　production: 2, preparing: 3, shipped: 4 }



end
