class OrdersController < ApplicationController

  def index
    authenticate_user
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def update
    Order.update(order_params)
    redirect_to request.referrer
  end

  def create
    new_order = Order.create( order_params )
    users_cart = CartItem.where('user_id = ?', current_user)
    users_cart.each do |item|
      OrderItem.create(:order_id => new_order.id, :status => 0, :user_id => current_user.id, :affiliate_id => item.affiliate_id, :product_id => item.product_id)
    end
    users_cart.each { |item| item.destroy }
    redirect_to request.referrer
  end

  def destroy
    order = Order.find(params[:id])
    order.destroy
    redirect_to request.referrer
  end

  private
  def order_params
    params.require(:order).permit(:user_id)
  end

end
