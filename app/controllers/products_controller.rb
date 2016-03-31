class ProductsController < ApplicationController

  impressionist :actions=>[:show,:index]

  def index
    binding.pry
    authenticate_anybody
    cart_counter
    @products = Product.order(priority: :desc).paginate(:per_page => 3, :page => params[:page])
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
    @tech = Product.where('category = ?', 'Tech').paginate(:per_page => 3, :page => params[:page])
  end

  def art_culture
    cart_counter
    @art_culture = Product.where('category = ?', 'Art_Culture').paginate(:per_page => 3, :page => params[:page])
  end

  def gadgets
    cart_counter
    @gadgets = Product.where('category = ?', 'Gadgets').paginate(:per_page => 3, :page => params[:page])
  end

  def apparel
    cart_counter
    @apparel = Product.where('category = ?', 'Apparel').paginate(:per_page => 3, :page => params[:page])
  end

  def accessories
    cart_counter
    @accessories = Product.where('category = ?', 'Accessories').paginate(:page => params[:page], :per_page => 3)
  end

  def essentials
    cart_counter
    @essentials = Product.where('category = ?', 'Essentials').paginate(:page => params[:page], :per_page => 3)
  end

  def best_sellers
    @best_sellers = Product.order(total_orders: :desc).paginate(:page => params[:page], :per_page => 3)
  end

  def new_arrivals
    @new_arrivals = Product.order(created_at: :desc).paginate(:page => params[:page], :per_page => 3)
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
    flash[:success] = "#{product.title} deleted!"
    redirect_to admins_path
  end

  def update
    authenticate_admin
    product = Product.find(params[:id])
    product.update(product_params)
    flash[:success] = "Product updated!"
    redirect_to request.referrer
  end

  def create
    authenticate_admin
    product = Product.create( product_params )
    if product.save
      flash[:success] = "Product created!"
      redirect_to edit_product_path(product.id)
    else
      flash[:error] = "Product not created, cannot have an image type of " + product.image_content_type
      redirect_to request.referrer
    end
  end

  private
  def product_params
    params.require(:product).permit(:user_id, :title, :description, :price, :category, :status, :feature_one, :feature_two, :feature_three, :feature_four, :feature_five, :total_orders, :image, :image_two, :image_three, :image_four, :image_five, :priority)
  end

end
