class ProductItem < ActiveRecord::Base
  belongs_to :product
  has_many :order_items, :dependent => :destroy
  has_many :cart_items, :dependent => :destroy
end
