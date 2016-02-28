class CartItemsController < ApplicationController

  def index
  end

  def create
    @cart_item = CartItem.create(cart_items_params)
    redirect_to request.referrer
  end

  private
  def cart_items_params
    params.require(:cart_item).permit(:user_id, :product_id, :quantity)
  end

end
