class User < ActiveRecord::Base
  has_secure_password(validations: false)

  has_many :addresses
  has_many :orders
  has_many :order_items, through: :orders
  has_many :products, :dependent => :destroy
  has_many :product_items, through: :products
  has_many :cart_items, :dependent => :destroy

  validates :password, confirmation: true, length: { in: 6..20 }, unless: :skip_user_validation
  validates :password_confirmation, presence: true, unless: :skip_user_validation
  validates :email, presence: true, uniqueness: true, unless: :skip_user_validation

  attr_accessor :skip_user_validation


  def self.from_omniauth(auth)
    if(auth.info.email)
      where(email: auth.info.email).first_or_create do |user|
      	user.email = auth.info.email
      	user.status = 0
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.oauth_token = auth.credentials.token
        user.save!
      end
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
       user.email = auth.info.email
       user.status = 0
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.oauth_token = auth.credentials.token
        user.save!
      end
    end
  end
end
