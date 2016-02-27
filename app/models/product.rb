class Product < ActiveRecord::Base
  belongs_to :affiliate
  has_many :orders
  has_many :inventories
end
