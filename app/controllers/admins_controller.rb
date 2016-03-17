class AdminsController < ApplicationController

  def index
    authenticate_admin
    # @user = User.new
    # @users = User.where('status = ?', 0)
    # @affiliates = User.where('status = ?', 1)
    # @product = Product.new
    # @products = Product.paginate(:page => params[:page], :per_page => 3)
    # @product_item = ProductItem.new
    @total_impressions = Impression.where('action_name = ?', 'index')
    @total_unique_views = Impression.select(:ip_address).uniq
    @weeks_unique_views = @total_unique_views.where('created_at >= ?', past_7_days)
    @total_show_impressions = Impression.where('action_name = ?', 'show')
    @weeks_impressions = Impression.where('action_name = ? AND created_at >= ?', 'index', past_7_days)
    @weeks_show_impressions = Impression.where('action_name = ? AND created_at >= ?', 'show', past_7_days)
    @top_selling_products = Product.order(total_orders: :desc).limit(4)

    top_selling_weeks_product_item_id = OrderItem.where('created_at >= ?', past_7_days).group(:product_item_id).order('count_id DESC').limit(1).count(:id).first[0]
    @top_selling_week_product_item = ProductItem.find(top_selling_weeks_product_item_id)

    total_orders = OrderItem.all
    @total_orders = 0
    @total_sales = 0
    @orders_24_hours = 0
    @sales_24_hours = 0
    @orders_7_days = 0
    @sales_7_days = 0
    @orders_30_days = 0
    @sales_30_days = 0
    total_orders.each do |item|
      @total_orders += item.quantity
      @total_sales += item.product_item.product.price.to_i
      if item.created_at >= past_24_hours
        @orders_24_hours += item.quantity
        @sales_24_hours += item.product_item.product.price.to_i
        @orders_7_days += item.quantity
        @sales_7_days += item.product_item.product.price.to_i
        @orders_30_days +=item.quantity
        @sales_30_days += item.product_item.product.price.to_i
      elsif item.created_at >= past_7_days
        @orders_7_days += item.quantity
        @sales_7_days += item.product_item.product.price.to_i
        @orders_30_days += item.quantity
        @sales_30_days += item.product_item.product.price.to_i
      elsif item.created_at >= past_30_days
        @orders_30_days += item.quantity
        @sales_30_days += item.product_item.product.price.to_i
      end
    end
  end

  def orders
    @weeks_orders = Order.where('created_at >= ?', past_7_days)
    @weeks_pending_orders = OrderItem.where('created_at >= ? AND status = ?', past_7_days, 0)
    @weeks_delivered_orders = OrderItem.where('created_at >= ? AND status = ?', past_7_days, 1)
  end

  def products
  end

  def users
  end

  def affiliates
  end

  def updated
    product = Product.find(params[:product_id])
    product.update(product_params)
    redirect_to request.referrer
  end


end
