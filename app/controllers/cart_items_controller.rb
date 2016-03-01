class CartItemsController < ApplicationController

  def create
    @cart_item = CartItem.create(cart_items_params)
    @product = Product.where('id = ?', @cart_item.product_id)
    if @cart_item.quantity <= @product[0].total_quantity
      @product[0].total_quantity = (@product[0].total_quantity - 1)
      @product[0].save
    else
      @cart_item.destroy
      puts "Not enough inventory"
    end
    redirect_to request.referrer
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
    params.require(:cart_item).permit(:user_id, :product_id, :affiliate_id, :quantity)
  end

end
