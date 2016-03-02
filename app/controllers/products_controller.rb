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

  def update
    authenticate_admin
    product = Product.find(params[:id])
    product.update(product_params)
    redirect_to request.referrer
  end

  def create
    authenticate_admin
    product = Product.create( product_params )
    redirect_to request.referrer
  end

  private
  def product_params
    params.require(:product).permit(:user_id, :title, :description, :price, :category, :size, :status, :picture, :admin_notes, :total_quantity, :XS_quantity, :S_quantity, :M_quantity, :L_quantity, :XL_quantity, :XXL_quantity)
  end

end
