class Address < ActiveRecord::Base
  belongs_to :user
  has_many :orders

  validates :zip, confirmation: true, length: {is: 5}
end
