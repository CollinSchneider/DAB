class Api::ProductsController < ApplicationController
  def index
  limit = (params[:limit] || 10).to_i
    # if params[:search]
    #   search_term = params[:search]
    #   violations = Violation.where("description ILIKE ?", "%#{search_term}%")
    #                         .limit(limit)
    # else
      page = (params[:page] || 0).to_i
      products = Product.offset(limit*page).limit(limit)
    # end
    render json: {products: products}
  end

  # def index
  #   dbProducts = Product.all
  #   render json: { products: dbProducts }
  # end

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
