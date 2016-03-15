class UsersController < ApplicationController

  def index
    if current_user
      redirect_to products_path
    end
    @user = User.new
  end

  def total_amount
    product_prices = current_user.cart_items.map do |cart_item|
      cart_item.quantity.to_i * cart_item.product_item.product.price.to_i
    end
    @amount = product_prices.reduce(0, :+)
  end

  def shipping
    cart_counter
    @current_user_address = current_user.addresses.where('active = ?', 'yes')
    total_amount
  end

  def profile
    @new_address = Address.new
    cart_counter
  end

  def affiliate
    authenticate_affiliate
    @total_orders = 0
    @total_sales = 0
    @todays_orders = []
    @weeks_orders = []
    @months_orders = []

    current_user.products.each do |product|
      product.product_items.each do |item|
        item.order_items.each do |order|
          @total_orders += 1
          @total_sales += order.product_item.product.price.to_i

          if order.created_at >= past_24_hours
            @todays_orders.push(order)
            @weeks_orders.push(order)
            @months_orders.push(order)
          elsif order.created_at >= past_7_days
            @weeks_orders.push(order)
            @months_orders.push(order)
          elsif order.created_at >= past_30_days
            @months_orders.push(order)
          end
        end
      end
    end
    todays_sales = @todays_orders.map { |item| item.product_item.product.price.to_i }
    @todays_sales = todays_sales.reduce(:+)
    weeks_sales = @weeks_orders.map{ |item| item.product_item.product.price.to_i }
    @weeks_sales = weeks_sales.reduce(:+)
    months_sales = @months_orders.map{ |item| item.product_item.product.price.to_i }
    @months_sales = months_sales.reduce(:+)
  end

  def create
    authenticate_anybody
    user = User.create( user_params )
    if User.where('email = ?', user.email).length > 1
      user.delete
      flash[:error] = "Email is already in use"
      # redirect_to request.referrer
    elsif user.password.length < 8
      user.delete
      flash[:error] = "Password must be at least 8 characters long"
    else
      # if user.save
        if user.status === 0
          session[:user_id] = user.id
        elsif user.status != 0
          redirect_to request.referrer
        end
    end
  end

  def cart
    authenticate_anybody
    @order = Order.new
    total_amount
    cart_counter
  end

  def destroy
    user = User.find(params[:id])
    user.delete
    redirect_to request.referrer
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :status)
  end

  private
  def order_params
    params.require(:order).permit(:user_id, :affiliate_id, :product_id, :shipping_number, :status)
  end

end
