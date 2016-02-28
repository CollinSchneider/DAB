class CartItemsController < ApplicationController

  # def index
  # end

  def create
    # if @product.total_quantity > 0
      @cart_item = CartItem.create(cart_items_params)
      @product = Product.where('id = ?', @cart_item.product_id)
      # @product[0].update( :total_quantity => (:total_quantity - 1) )
      @product[0].total_quantity = (@product[0].total_quantity - 1)
      @product[0].save
      redirect_to request.referrer
    # else
      # puts "Not enough inventory"
    # end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    @product = Product.where('id = ?', cart_item.product_id)
    @product[0].total_quantity = (@product[0].total_quantity + 1)
    @product[0].save
    cart_item.destroy
    redirect_to request.referrer
  end

  private
  def cart_items_params
    params.require(:cart_item).permit(:user_id, :product_id, :quantity)
  end

end
