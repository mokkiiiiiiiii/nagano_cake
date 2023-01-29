class Order < ApplicationRecord

  has_many :cart_items #中間テーブル
  has_many :items, through: :cart_items  #注文には商品が多くある
  enum payment_method: { credit_card: 0, transfer: 1 }
  has_many :order_details

  belongs_to :customer
end
