class UsersController < ApplicationController

  def index
    if current_user
      redirect_to products_path
    end
    @user = User.new
  end

  def affiliate
    authenticate_affiliate
    @affiliate_orders = OrderItem.where('affiliate_id = ?', current_user.id)
  end

  def create
    user = User.create( user_params )
    if user.save
      if user.status === 0
        session[:user_id] = user.id
        redirect_to root_path
      elsif user.status != 0
        redirect_to request.referrer
      end
    else
      flash[:error] = user.errors.full_messages
      redirect_to request.referrer
    end
  end

  def cart
    product_id_array = current_user.cart_items.map { |item| item.product_id }
    @cart = Product.find(product_id_array)
    @order = Order.new
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
