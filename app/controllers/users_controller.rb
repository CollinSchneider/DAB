class UsersController < ApplicationController

  def index
    if current_user
      redirect_to products_path
    end
    @user = User.new
  end

  def affiliate
    authenticate_affiliate
  end

  def create
    authenticate_anybody
    user = User.create( user_params )
    if user.save
      if user.status === 0
        session[:user_id] = user.id
      elsif user.status != 0
        redirect_to request.referrer
      end
    else
      flash[:error] = user.errors.full_messages
      redirect_to request.referrer
    end
  end

  def cart
    authenticate_anybody
    @order = Order.new
  end

  def destroy
    user = User.find(params[:id])
    user.delete
    redirect_to request.referrer
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :status)
  end

  private
  def order_params
    params.require(:order).permit(:user_id, :affiliate_id, :product_id, :shipping_number, :status)
  end

end
