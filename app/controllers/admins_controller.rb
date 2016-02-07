class AdminsController < ApplicationController

  def index
    authenticate_admin
    @user = User.new
    @users = User.where('status = ?', 0)
    @affiliates = User.where('status = ?', 1)
    @new_products = Product.where('status = ?', 0)
    # @product = Product.find(params[:product_id])
  end

  def edit
  end

  def updated
    product = Product.find(params[:product_id])
    product.update(product_params)
    redirect_to request.referrer
  end

  # def create
  #   authenticate_admin
  #   user = User.create( user_params )
  #   if user.save
  #     redirect_to request.referrer
  #   else
  #     flash[:error] = user.errors.full_messages
  #     redirect_to request.referrer
  #   end
  # end
  #
  # private
  # def user_params
  #   params.require(:user).permit(:email, :password, :status)
  # end

end
