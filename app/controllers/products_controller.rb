class ProductsController < ApplicationController

  impressionist :actions=>[:show,:index]

  def index
    authenticate_anybody
    cart_counter
    @active_banners = Banner.where('status = ?', 'Active')
    @products = Product.order(priority: :desc).paginate(:per_page => 6, :page => params[:page])
  end

  def show
    authenticate_anybody
    cart_counter
    # @product = Product.find(params[:id])
    @product = Product.find_by(slug: params[:id])
    @related_products = Product.where('category = ? AND id != ?', @product.category, @product.id).order(total_orders: :desc).limit(3)
    if @product.embedded_video != nil
      @embedded_video = @product.embedded_video.html_safe
    end
    set_meta_tags title: @product.title,
                  description: @product.description,
                  keywords: @product.meta_keyword
    @product_item = ProductItem.new
    @cart_item = CartItem.new
  end

  def new
    authenticate_admin
    @product = Product.new
  end

  def edit
    authenticate_admin
    @product = Product.find_by(slug: params[:id])
    @product_item = ProductItem.new
  end

  def tech
    cart_counter
    @tech = Product.where('category = ?', 'Tech').paginate(:per_page => 6, :page => params[:page])
  end

  def art_culture
    cart_counter
    @art_culture = Product.where('category = ?', 'Art_Culture').paginate(:per_page => 6, :page => params[:page])
  end

  def gadgets
    cart_counter
    @gadgets = Product.where('category = ?', 'Gadgets').paginate(:per_page => 6, :page => params[:page])
  end

  def apparel
    cart_counter
    @apparel = Product.where('category = ?', 'Apparel').paginate(:per_page => 6, :page => params[:page])
  end

  def accessories
    cart_counter
    @accessories = Product.where('category = ?', 'Accessories').paginate(:page => params[:page], :per_page => 6)
  end

  def essentials
    cart_counter
    @essentials = Product.where('category = ?', 'Essentials').paginate(:page => params[:page], :per_page => 6)
  end

  def best_sellers
    @best_sellers = Product.order(total_orders: :desc).paginate(:page => params[:page], :per_page => 6)
  end

  def new_arrivals
    @new_arrivals = Product.order(created_at: :desc).paginate(:page => params[:page], :per_page => 6)
  end

  def featured
    @featured = Product.where('featured = ?', 'Featured').paginate(:page => params[:page], :per_page => 6)
  end

  def destroy
    product = Product.find_by(slug: params[:id])
    product.delete
    flash[:success] = "#{product.title} deleted!"
    redirect_to admins_path
  end

  def update
    authenticate_admin
    product = Product.find_by(slug: params[:id])
    product.update(product_params)
    product.slug = product.title.downcase.gsub(" ", "-")
    if product.embedded_video.present?
      product.embedded_video = convert_youtube_url(product.embedded_video)
    end
    product.save
    if product.save
      flash[:success] = "Product updated!"
      redirect_to edit_product_path(product.slug)
    else
      flash[:error] = product.errors.full_messages
      redirect_to request.referrer
    end
  end

  def convert_youtube_url(youtube_url)
  if youtube_url[/youtu\.be\/([^\?]*)/]
    youtube_id = $1
  else
    youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
    youtube_id = $5
  end
    %Q{<iframe title='YouTube video player' class = "product-video" src='http://www.youtube.com/embed/#{ youtube_id }' frameborder='0' allowfullscreen></iframe>}
  end

  def create
    authenticate_admin
    product = Product.create( product_params )
    product.slug = product.title.downcase.gsub(" ", "-")
    if product.embedded_video.present?
      product.embedded_video = convert_youtube_url(product.embedded_video)
    end
    if product.save
      flash[:success] = "Product created!"
      redirect_to edit_product_path(product.slug)
    else
      # flash[:error] = "Product not created, cannot have an image type of " + product.image_content_type
      flash[:error] = product.errors.full_messages
      redirect_to request.referrer
    end
  end

  private
  def product_params
    params.require(:product).permit(:user_id, :title, :description, :price, :category, :status, :feature_one, :feature_two, :feature_three, :feature_four, :feature_five, :total_orders, :image, :image_two, :image_three, :image_four, :image_five, :priority, :embedded_video, :video_status, :featured, :meta_keyword, :slug)
  end

end
