class AffiliatesController < ApplicationController

  def index
    authenticate_affiliate
    @product = Product.new
    @users = User.all
  end

  def sell
    authenticate_affiliate
    @product = Product.new
  end

  def create
  end

end
