class ProductsController < ApplicationController

  impressionist :actions=>[:show,:index]

  def cart_counter
    cart_quantity = []
    current_user.cart_items.each do |item|
      cart_quantity.push(item.quantity)
    end
    @cart_quantity = cart_quantity.reduce(:+)
  end

  def index
    authenticate_anybody
    cart_counter
    @products = Product.page(params[:page]).per(9)
  end

  def show
    authenticate_anybody
    cart_counter
    @product = Product.find(params[:id])
    @product_item = ProductItem.new
    @cart_item = CartItem.new
  end

  def new
    authenticate_admin
    @product = Product.new
  end

  def edit
    authenticate_admin
    @product = Product.find(params[:id])
    @product_item = ProductItem.new
  end

  def tech
    cart_counter
    @tech = Product.where('category = ?', 'Tech').paginate(:per_page => 9, :page => params[:page])
  end

  def art_culture
    cart_counter
    @art_culture = Product.where('category = ?', 'Art_Culture').paginate(:per_page => 9, :page => params[:page])
  end

  def gadgets
    cart_counter
    @gadgets = Product.where('category = ?', 'Gadgets').paginate(:per_page => 9, :page => params[:page])
  end

  def apparel
    cart_counter
    @apparel = Product.where('category = ?', 'Apparel').paginate(:per_page => 9, :page => params[:page])
  end

  def accessories
    cart_counter
    @accessories = Product.where('category = ?', 'Accessories').paginate(:page => params[:page], :per_page => 9)
  end

  def essentials
    cart_counter
    @essentials = Product.where('category = ?', 'Essentials').paginate(:page => params[:page], :per_page => 9)
  end

  def edit
    authenticate_admin
    @product = Product.find(params[:id])
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
    binding.pry
    flash[:success] = "Product created!"
    # redirect_to edit_product_path(product.id)
    redirect_to request.referrer
  end

  private
  def product_params
    params.require(:product).permit(:user_id, :title, :description, :price, :category, :size, :status, :feature_one, :feature_two, :feature_three, :feature_four, :feature_five, :total_orders, :image)
  end

end
