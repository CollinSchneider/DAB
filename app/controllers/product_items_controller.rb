class ProductItemsController < ApplicationController

  def index
    authenticate_anybody
  end

  def create
    authenticate_admin
    ProductItem.create(product_params)
    flash[:success] = "Created Product Item"
    redirect_to request.referrer
  end

  def destroy
    authenticate_admin
    product = ProductItem.find(params[:id])
    product.destroy
    redirect_to request.referrer
  end

  private
  def product_params
    params.require(:product_item).permit(:product_id, :description, :quantity)
  end

end
