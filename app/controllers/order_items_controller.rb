class OrderItemsController < ApplicationController

  def index
  end

  def create
    @order_item = OrderItem.create( order_items_params )
    redirect_to request.referrer
  end

  def edit
    @edit_order_item = OrderItem.find(params[:id])
    redirect_to request.referrer
  end

  def update
    @edit_order_item = OrderItem.find(params[:id])
    @edit_order_item.update( order_items_params )
    redirect_to request.referrer
  end

  def destroy
    order = OrderItem.find(params[:id])
    order.delete
    redirect_to request.referrer
  end

  private
  def order_items_params
    params.require(:order_item).permit(:product_item_id, :affiliate_id, :user_id, :shipping_number, :status)
  end

end
