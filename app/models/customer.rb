class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    self.last_name+" "+self.first_name
  end

  def furigana_full_name
    self.furigana_last_name+" "+self.furigana_first_name
  end
    # ↑注文履歴とかでフルネームを表示する方法

   # 退会機能 is_deletedがfalseならtrueを返すようにしている

  has_many :addresses, dependent: :destroy
  # 会員は配送先を沢山持っている
  has_many :orders, dependent: :destroy
  # 会員は注文を沢山持っている
  has_many :cart_items, dependent: :destroy
  # 会員はカートアイテムを沢山持っている

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :furigana_last_name, presence: true
  validates :furigana_first_name, presence: true
  validates :address, presence: true
  validates :post_code, presence: true, length: { is: 7 }
  validates :address, presence: true
  validates :tel_number, presence: true, length: { maximum: 13 }

  # def is_active
  #   if is_deleted == true
  #     "退会"
  #   else
  #     "有効"
  #   end
  # end


  # enum is_active: {Available: true, Invalid: false}

  def active_for_authentication?
    super && (self.is_active === true)
  end


end
