class Api::ProductsController < ApplicationController
  def index
  limit = (params[:limit] || 10).to_i

      page = (params[:page] || 0).to_i
      products = Product.offset(limit*page).limit(limit)
    render json: {products: products}
  end

  # def tech
  #   products = Product.where('category = ?', tech)
  #   render json: { products: products }
  # end
  #
  # def art_culture
  #   products = Product.where('category = ?', art_culture)
  #   render json: { products: products }
  # end
  #
  # def gadgets
  #   products = Product.where('category = ?', gadgets)
  #   render json: { products: products }
  # end
  #
  # def apparel
  #   products = Product.where('category = ?', apparel)
  #   render json: { products: products }
  # end
  #
  # def accessories
  #   products = Product.where('category = ?', accessories)
  #   render json: { products: products }
  # end
  #
  # def essentials
  #   products = Product.where('category = ?', essentials)
  #   render json: { products: products }
  # end

  def create
    new_product = Product.create(product_params)
    render json: new_product
  end

  def destroy
    product = Product.find(params[:id])
    product.delete
    render json: product
  end

  def update
    product = Product.find(params[:id])
    updated_product = product.update(product_params)
    render json: updated_product
  end

  private
  def product_params
    params.require(:product).permit(:user_id, :title, :description, :price, :category, :size, :status, :picture, :total_sales)
  end

end
