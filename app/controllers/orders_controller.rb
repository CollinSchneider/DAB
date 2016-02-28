class OrdersController < ApplicationController

  def index
    authenticate_user
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    Order.create( order_params )
    users_cart = CartItem.where('user_id = ?', current_user)
    users_cart.each { |item| item.destroy }
    redirect_to request.referrer
  end

  private
  def order_params
    params.require(:order).permit(:user_id, :affiliate_id, :product_id, :shipping_number, :status)
  end

end
