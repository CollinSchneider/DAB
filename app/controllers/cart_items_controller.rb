class CartItemsController < ApplicationController

  # def index
  # end

  def create
    # @product = Product.find(params[:id])
    # if @product.total_quantity > 0
      @cart_item = CartItem.create(cart_items_params)
      # @product.total_quantity = @product.total_quantity - 1
      redirect_to request.referrer
    # else
      # puts "Not enough inventory"
    # end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    # cart_item = CartItem.where('product_id = ?', item_id)
    cart_item.destroy
    redirect_to request.referrer
  end

  private
  def cart_items_params
    params.require(:cart_item).permit(:user_id, :product_id, :quantity)
  end

end
