class AdminsController < ApplicationController

  def index
    authenticate_admin
    @user = User.new
    @users = User.where('status = ?', 0)
    @affiliates = User.where('status = ?', 1)
    @product = Product.new
    # @product = Product.find(params[:product_id])
  end

  def edit
  end

  def updated
    product = Product.find(params[:product_id])
    product.update(product_params)
    redirect_to request.referrer
  end


end
