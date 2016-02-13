class Product < ActiveRecord::Base
  belongs_to :affiliate
  has_many :orders
  has_many :inventories
  accepts_nested_attributes_for :inventories, allow_destroy: true
end
