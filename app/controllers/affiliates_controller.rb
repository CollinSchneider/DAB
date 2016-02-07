class AffiliatesController < ApplicationController

  def index
    authenticate_affiliate
    @product = Product.new
    @users = User.all
  end

  def create
    product = Product.create( product_params )
    redirect_to request.referrer
  end

  private
  def affiliate_params
    params.require(:affiliate).permit(:email, :password, :status)
  end

end
