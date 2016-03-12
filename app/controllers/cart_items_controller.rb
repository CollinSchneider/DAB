class CartItemsController < ApplicationController

  def create
    @cart_item = CartItem.create(cart_items_params)
    product_item = @cart_item.product_item
    if @cart_item.quantity <= product_item.quantity
      product_item.quantity = (product_item.quantity - @cart_item.quantity)
      product_item.save
      # flash[:success] = @cart_item.quantity, product_item.description, product_item.product.title, " added to cart!"
      flash[:success] = "Added to cart!"
    else
      flash[:error] = "Not enough inventory"
      @cart_item.destroy
      # flash[:error] = "Not enough inventory, only have ", product_item.quantity, product_item.product.title, " left."
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
    # cart_item.product_item(:quantity => (cart_item.product_item.quantity - quantity_difference), :status => 1 )
    # cart_item.product_item.status = 1
    cart_item.product_item.save
    flash[:success] = "Quantity updated!"
    if cart_item.product_item.quantity < 0
      cart_item.quantity = original_cart_item_quantity
      cart_item.save
      cart_item.product_item.quantity = original_product_item_quantity
      cart_item.product_item.save
      flash[:error] = "Not enough inventory, cannot update quantity"
    # elsif cart_item.product_item.quantity = 0
    #   cart_item.product_item.status = 0
    #   cart_item.product_item.save
    end

    redirect_to request.referrer
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    product_item = cart_item.product_item
    product_item.quantity = (product_item.quantity + cart_item.quantity)
    product_item.save
    cart_item.destroy
    flash[:success] = "Item Removed!"
    redirect_to request.referrer
  end

  private
  def cart_items_params
    params.require(:cart_item).permit(:user_id, :product_item_id, :affiliate_id, :quantity)
  end

end
