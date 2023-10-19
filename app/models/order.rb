class Order < ApplicationRecord

#payment_methodへenumを定義
enum payment_method: { credit_card: 0, transfer: 1 }
  

end
