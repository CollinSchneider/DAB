class UsersController < ApplicationController

  def index
    if current_user
      redirect_to products_path
    end
    @user = User.new
  end

  def affiliate
    authenticate_affiliate
    # @affiliate_new_orders_array = OrderItem.where('affiliate_id = ?', current_user.id)
    # affiliate_products = @affiliate_new_orders_array.map { |item| item.product_id }
    # @affiliate_order_products = Product.find(affiliate_products)
  end

  def create
    authenticate_anybody
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
    authenticate_anybody
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
