class Api::ProductsController < ApplicationController

  def index
    dbProducts = Product.all
    render json: { products: dbProducts }
  end

  def create
    new_product = Product.create(product_params)
    render json: new_product
  end

  def update
    product = Product.find(params[:id])
    updated_product = product.update(product_params)
    render json: updated_product
  end

  private
  def product_params
    params.require(:product).permit(:user_id, :title, :description, :price, :category, :size, :status, :picture, :XXL_quantity, :XL_quantity, :L_quantity, :M_quantity, :S_quantity, :XS_quantity, :total_quantity)
  end

end
