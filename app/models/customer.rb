class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def full_name
    self.last_name+" "+self.first_name
    # ↑注文履歴とかでフルネームを表示する方法

  end
  
  has_many :addresses, dependent: :destroy
  # 会員は配送先を沢山持っている
  has_many :orders, dependent: :destroy
  # 会員は注文を沢山持っている
  has_many :cart_items, dependent: :destroy
  # 会員はカートアイテムを沢山持っている
end
