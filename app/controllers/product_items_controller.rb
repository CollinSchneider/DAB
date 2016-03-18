class ProductItemsController < ApplicationController

  def index
    authenticate_anybody
  end

  def new
    @product_item = ProductItem.new
  end

  def create
    authenticate_admin
    product_item = ProductItem.create(product_params)
    product_item.product.status = 0
    product_item.product.save
    flash[:success] = "Created Product Item"
    redirect_to request.referrer
  end

  def update
    product_item = ProductItem.find(params[:id])
    product_item.update(product_params)
    if product_item.quantity > 0
      product_item.status = 0
      product_item.product.status = 0
      product_item.save
      product_item.product.save
    elsif product_item.quantity === 0
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
    flash[:success] = "Updated #{product_item.description} #{product_item.product.title}"
    redirect_to request.referrer
  end

  def destroy
    authenticate_admin
    product_item = ProductItem.find(params[:id])
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
    product_item.destroy
    if product_item.product.product_items.count === 0
      product_item.product.status = 1
      product_item.product.save
    end

    redirect_to request.referrer
  end

  private
  def product_params
    params.require(:product_item).permit(:product_id, :description, :quantity, :status)
  end

end
