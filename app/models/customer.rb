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

end
