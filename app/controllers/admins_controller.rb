class AdminsController < ApplicationController

  def index
    authenticate_admin
    @user = User.new
    @users = User.where('status = ?', 0)
    @affiliates = User.where('status = ?', 1)
    @product = Product.new
    @product_item = ProductItem.new
    @products = Product.all

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

  def edit
  end

  def updated
    product = Product.find(params[:product_id])
    product.update(product_params)
    redirect_to request.referrer
  end


end
