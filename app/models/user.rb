class User < ActiveRecord::Base
  has_secure_password

  has_many :orders
  has_many :order_items, through: :orders
  has_many :products
  has_many :product_items, through: :products
  has_many :cart_items
end
