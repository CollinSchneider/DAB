class User < ActiveRecord::Base
  has_secure_password(validations: false)

  has_many :orders
  has_many :order_items, through: :orders
  has_many :products, :dependent => :destroy
  has_many :product_items, through: :products
  has_many :cart_items, :dependent => :destroy

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.save!
    end
  end

end
