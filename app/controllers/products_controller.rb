class ProductsController < ApplicationController

  def index
    authenticate_anybody
    @accepted_products = Product.where('status = ?', 2)
    @rejected_products = Product.where('status = ?', 1)
    @submitted_products = Product.where('status = ?', 0)
    @affiliate_products = Product.where('affiliate_id = ?', current_user)
  end

  def show
    authenticate_anybody
    @product = Product.find(params[:id])
    @new_product_item = ProductItem.new
    @cart_item = CartItem.new
  end

  def new
    authenticate_admin
    @product = Product.new
  end

  def edit
    authenticate_admin
    @product = Product.find(params[:product_id])
  end

  def destroy
    product = Product.find(params[:id])
    product.product_items.each do |item|
      item.delete
    end
    product.delete
    redirect_to request.referrer
  end

  def update
    authenticate_admin
    product = Product.find(params[:id])
    product.update(product_params)
    redirect_to request.referrer
  end

  def create
    authenticate_admin
    product = Product.create( product_params )
    redirect_to product_path(product.id)
  end

  private
  def product_params
    params.require(:product).permit(:user_id, :title, :description, :price, :category, :size, :status, :picture, :feature_one, :feature_two, :feature_three, :feature_four, :feature_five)
  end

end
