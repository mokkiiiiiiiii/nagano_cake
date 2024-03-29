class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  
  def full_name
  last_name + first_name
  end
  
  #enum is_deleted: {Available: true, Invalid: false}
    #有効会員はfalse、退会済み会員はtrue


  
end
