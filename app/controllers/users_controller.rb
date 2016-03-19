class UsersController < ApplicationController

  def index
    if current_user
      redirect_to products_path
    end
  end

  def signup
    @user = User.new
  end

  def total_amount
    if current_user != nil
      product_prices = current_user.cart_items.map do |cart_item|
        cart_item.quantity.to_i * cart_item.product_item.product.price.to_i
      end
      @amount = product_prices.reduce(0, :+)
    end
  end

  def shipping
    authenticate_user
    cart_counter
    total_amount
    current_user_address
    calc_tax_rate
  end

  def profile
    @new_address = Address.new
    cart_counter
  end

  def addresses
    cart_counter
  end

  def account
    cart_counter
  end

  def affiliate
    authenticate_affiliate
    @total_orders = 0
    @total_sales = 0
    todays_orders = []
    weeks_orders = []
    months_orders = []

    current_user.products.each do |product|
      product.product_items.each do |item|
        item.order_items.each do |order|
          @total_orders += order.quantity
          @total_sales += order.product_item.product.price.to_i * order.quantity

          if order.created_at >= past_24_hours
            todays_orders.push(order)
            weeks_orders.push(order)
            months_orders.push(order)
          elsif order.created_at >= past_7_days
            weeks_orders.push(order)
            months_orders.push(order)
          elsif order.created_at >= past_30_days
            months_orders.push(order)
          end
        end
      end
    end
    
    todays_sales = todays_orders.map { |item| item.product_item.product.price.to_i * item.quantity }
    @todays_sales = todays_sales.reduce(:+)
    todays_orders = todays_orders.map { |order| order.quantity }
    @todays_orders = todays_orders.reduce(:+)
    weeks_sales = weeks_orders.map{ |item| item.product_item.product.price.to_i * item.quantity }
    @weeks_sales = weeks_sales.reduce(:+)
    weeks_orders = weeks_orders.map { |order| order.quantity }
    @weeks_orders = weeks_orders.reduce(:+)
    months_sales = months_orders.map{ |item| item.product_item.product.price.to_i * item.quantity }
    @months_sales = months_sales.reduce(:+)
    months_orders = months_orders.map { |order| order.quantity }
    @months_orders = months_orders.reduce(:+)
  end

  def create
    user = User.create( user_params )
    if user.save
      if user.status === 0
        session[:user_id] = user.id
        redirect_to products_path
      elsif user.status === 1
        flash[:success] = "New Affiliate Created!"
        redirect_to request.referrer
      elsif user.status === 2
        flash[:success] = "New Admin Created!"
        redirect_to request.referrer
      end
    else
      flash[:error] = user.errors.full_messages
      redirect_to request.referrer
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def cart
    authenticate_anybody
    # authenticate_user
    # if current_user = nil
    #   redirect_to root_path
    # else
      @order = Order.new
      total_amount
      cart_counter
    # end
  end

  def update
    user = User.find(params[:id])
    updated_user = user.update(user_params)
    if user.save
      flash[:success] = "Information Updated!"
    else
      flash[:error] = user.errors.full_messages
    end
    redirect_to request.referrer
  end

  def destroy
    user = User.find(params[:id])
    user.delete
    redirect_to request.referrer
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :status)
  end

  private
  def order_params
    params.require(:order).permit(:user_id, :affiliate_id, :product_id, :shipping_number, :status)
  end

end
