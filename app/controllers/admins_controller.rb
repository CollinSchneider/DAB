class AdminsController < ApplicationController

  def index
    authenticate_admin
    @total_impressions = Impression.where('action_name = ?', 'index')
    @total_unique_views = Impression.select(:ip_address).uniq
    @weeks_unique_views = @total_unique_views.where('created_at >= ?', past_7_days)
    @total_show_impressions = Impression.where('action_name = ?', 'show')
    @weeks_impressions = Impression.where('action_name = ? AND created_at >= ?', 'index', past_7_days)
    @weeks_show_impressions = Impression.where('action_name = ? AND created_at >= ?', 'show', past_7_days)
    @top_selling_products = Product.order(total_orders: :desc).limit(4)
    @weeks_orders = Order.where('created_at >= ?', past_7_days).count

    total_orders = OrderItem.all
    @total_orders = 0
    @total_sales = 0
    @orders_24_hours = 0
    @sales_24_hours = 0
    @orders_7_days = 0
    @sales_7_days = 0
    @orders_30_days = 0
    @sales_30_days = 0
    affiliate_week_sales = {}
    @top_selling_week_product_array = {}

    total_orders.each do |item|
      @total_orders += item.quantity
      @total_sales += item.product_item.product.price.to_i * item.quantity

      if item.created_at >= past_24_hours
        if affiliate_week_sales[item.product_item.product.user.email] === nil
          affiliate_week_sales[item.product_item.product.user.email] = item.product_item.product.price.to_i * item.quantity
        else
          affiliate_week_sales[item.product_item.product.user.email] += item.product_item.product.price.to_i * item.quantity
        end

        if @top_selling_week_product_array[item.product_item.product.title] === nil
          @top_selling_week_product_array[item.product_item.product.title] = item.quantity
        else
          @top_selling_week_product_array[item.product_item.product.title] += item.quantity
        end
        @top_selling_week_product = @top_selling_week_product_array.max_by{|a,b|a}
        @top_selling_affiliate = affiliate_week_sales.max_by{|a,b| a}

        @orders_24_hours += item.quantity
        @sales_24_hours += item.product_item.product.price.to_i * item.quantity
        @orders_7_days += item.quantity
        @sales_7_days += item.product_item.product.price.to_i * item.quantity
        @orders_30_days +=item.quantity
        @sales_30_days += item.product_item.product.price.to_i * item.quantity
      elsif item.created_at >= past_7_days
        @orders_7_days += item.quantity
        @sales_7_days += item.product_item.product.price.to_i * item.quantity
        @orders_30_days += item.quantity
        @sales_30_days += item.product_item.product.price.to_i * item.quantity
      elsif item.created_at >= past_30_days
        @orders_30_days += item.quantity
        @sales_30_days += item.product_item.product.price.to_i * item.quantity
      end

    end
  end

  def orders
    @weeks_orders = Order.where('created_at >= ?', past_7_days)
    @weeks_pending_orders = OrderItem.where('created_at >= ? AND status = ?', past_7_days, 0)
    @weeks_delivered_orders = OrderItem.where('created_at >= ? AND status = ?', past_7_days, 1)
    @affiliates = User.where('status = ?', 1)
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
