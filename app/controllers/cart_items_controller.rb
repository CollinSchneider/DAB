class CartItemsController < ApplicationController

  def create
    @cart_item = CartItem.create(cart_items_params)
    product_item = @cart_item.product_item
    if @cart_item.quantity <= product_item.quantity
      product_item.quantity = (product_item.quantity - @cart_item.quantity)
      product_item.save
      # current_user.cart_items.each do |user_cart_item|
      #   if user_cart_item.product_item_id === @cart_item.product_item.id
      #     user_cart_item.quantity += @cart_item.quantity
      #     @cart_item.delete
      #   end
      # end

      flash[:success] = "#{@cart_item.quantity} #{@cart_item.product_item.description} #{@cart_item.product_item.product.description} added to cart!"
      if product_item.quantity === 0
        UserMailer.low_inventory_email(product_item.product.user, product_item).deliver
        product_item.status = 1
        product_item.save
        inventory_status = 0
        product_item_count = product_item.product.product_items.count
        product_item.product.product_items.each do |item|
          if item.status === 1
            inventory_status += 1
            if inventory_status === product_item_count
              item.product.status = 1
              item.product.save
            end
          end
        end
      end
    else
      @cart_item.quantity = @cart_item.product_item.quantity
      @cart_item.product_item.quantity = 0
      @cart_item.save
      @cart_item.product_item.save
      UserMailer.low_inventory_email(product_item.product.user, product_item).deliver
      # current_user.cart_items.each do |user_cart_item|
      #   if user_cart_item.product_item_id === @cart_item.product_item.id
      #     user_cart_item.quantity += @cart_item.quantity
      #     @cart_item.delete
      #   end
      # end
      product_item.status = 1
      product_item.save
      inventory_status = 0
      product_item_count = product_item.product.product_items.count
      product_item.product.product_items.each do |item|
        if item.status === 1
          inventory_status += 1
          if inventory_status === product_item_count
            item.product.status = 1
            item.product.save
          end
        end
      end

      flash[:success] = "Only enough inventory for #{@cart_item.quantity} #{@cart_item.product_item.description} #{@cart_item.product_item.product.title}"
    end
    redirect_to request.referrer
  end

  def check_product_status
    cart_item.product_item.status = 1
    cart_item.product_item.save
    inventory_status = 0
    product_item_count = cart_item.product_item.product.product_items.count
    cart_item.product_item.product.product_items.each do |item|
      if item.status === 1
        inventory_status += 1
        if inventory_status === product_item_count
          item.product.status = 1
          item.product.save
        end
      end
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    original_cart_item_quantity = cart_item.quantity
    original_product_item_quantity = cart_item.product_item.quantity

    cart_item.update(cart_items_params)
    quantity_difference = cart_item.quantity - original_cart_item_quantity

    cart_item.product_item.quantity = (cart_item.product_item.quantity - quantity_difference)
    cart_item.product_item.status = 0
    cart_item.product_item.product.status = 0

    cart_item.product_item.save
    cart_item.product_item.product.save
    flash[:success] = "Quantity updated to #{cart_item.quantity}!"
    if cart_item.product_item.quantity < 0
      cart_item.quantity += cart_item.product_item.quantity
      cart_item.save
      cart_item.product_item.quantity -= cart_item.product_item.quantity
      cart_item.product_item.save

      cart_item.product_item.status = 1
      cart_item.product_item.save
      inventory_status = 0
      product_item_count = cart_item.product_item.product.product_items.count
      cart_item.product_item.product.product_items.each do |item|
        if item.status === 1
          inventory_status += 1
          if inventory_status === product_item_count
            item.product.status = 1
            item.product.save
          end
        end
      end

      flash[:success] = "Quantity updated, only enough product inventory for #{cart_item.quantity}"
    elsif cart_item.product_item.quantity === 0
      cart_item.product_item.status = 1
      cart_item.product_item.save
      inventory_status = 0
      product_item_count = cart_item.product_item.product.product_items.count
      cart_item.product_item.product.product_items.each do |item|
        if item.status === 1
          inventory_status += 1
          if inventory_status === product_item_count
            item.product.status = 1
            item.product.save
          end
        end
      end
    end

    redirect_to request.referrer
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    product_item = cart_item.product_item
    product_item.quantity = (product_item.quantity + cart_item.quantity)
    product_item.status = 0
    product_item.product.status = 0
    product_item.save
    product_item.product.save
    cart_item.destroy
    flash[:success] = "#{cart_item.product_item.product.title} Removed!"
    redirect_to request.referrer
  end

  private
  def cart_items_params
    params.require(:cart_item).permit(:user_id, :product_item_id, :affiliate_id, :quantity)
  end

end
