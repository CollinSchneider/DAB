class CartItemsController < ApplicationController

  def create
    @cart_item = CartItem.create(cart_items_params)
    product_item = @cart_item.product_item
    if @cart_item.quantity <= product_item.quantity
      product_item.quantity = (product_item.quantity - @cart_item.quantity)
      product_item.save
    else
      @cart_item.destroy
      puts "Not enough inventory"
    end
    redirect_to request.referrer
  end

  def update
    cart_item = CartItem.find(params[:id])
    original_cart_item_quantity = cart_item.quantity
    original_product_item_quantity = cart_item.product_item.quantity

    cart_item.update(cart_items_params)
    quantity_difference = cart_item.quantity - original_cart_item_quantity
    
    cart_item.product_item.quantity = (cart_item.product_item.quantity - quantity_difference)
    cart_item.product_item.save
    if cart_item.quantity > cart_item.product_item.quantity
      cart_item.quantity = original_cart_item_quantity
      cart_item.product_item.quantity = original_product_item_quantity
      puts("Not enough inventory, is " + cart_item.quantity + " ok?")
    end
    redirect_to request.referrer
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    product_item = cart_item.product_item
    product_item.quantity = (product_item.quantity + cart_item.quantity)
    product_item.save
    cart_item.destroy
    redirect_to request.referrer
  end

  private
  def cart_items_params
    params.require(:cart_item).permit(:user_id, :product_item_id, :affiliate_id, :quantity)
  end

end
