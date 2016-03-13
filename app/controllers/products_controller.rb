class ProductsController < ApplicationController

  impressionist :actions=>[:show,:index]

  def index
    authenticate_anybody
    @products = Product.paginate(:page => params[:page], :per_page => 6)
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
    @product = Product.find(params[:id])
    @new_product_item = ProductItem.new
  end

  def tech
    @tech = Product.where('category = ?', 'Tech').paginate(:page => params[:page], :per_page => 3)
  end

  def art_culture
    @art_culture = Product.where('category = ?', 'Art_culture').paginate(:page => params[:page], :per_page => 3)
  end

  def gadgets
    @gadgets = Product.where('category = ?', 'Gadgets').paginate(:page => params[:page], :per_page => 3)
    # @gadgets = gadgets.paginate(:page => params[:page], :per_page => 3)
  end

  def apparel
    @apparel = Product.where('category = ?', 'Apparel').paginate(:page => params[:page], :per_page => 3)
  end

  def accessories
    @accessories = Product.where('category = ?', 'Accessories').paginate(:page => params[:page], :per_page => 3)
  end

  def essentials
    @essentials = Product.where('category = ?', 'Essentials').paginate(:page => params[:page], :per_page => 3)
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
    flash[:success] = product.title + " created!"
    redirect_to edit_product_path(product.id)
  end

  private
  def product_params
    params.require(:product).permit(:user_id, :title, :description, :price, :category, :size, :status, :feature_one, :feature_two, :feature_three, :feature_four, :feature_five, :total_orders, :image)
  end

end
