class Product < ActiveRecord::Base
  belongs_to :user
  has_many :product_items, :dependent => :destroy
  has_many :cart_items, through: :product_items
  has_many :order_items, through: :product_items

  is_impressionable
end
