class UsersController < ApplicationController

  def index
    if current_user
      redirect_to products_path
    end
    @user = User.new
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
          # past_24_hours = Time.now.utc - (60 * 60 * 24)
          # past_7_days = Time.now.utc - (60 * 60 * (24*7))
          # past_30_days = Time.now.utc - (60 * 60 * (24*30))
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
          # @todays_sales = item.order_items.where(item.order_items.created_at > (Time.now - (60 * 60 * 24)))
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

  # Today's date is <%= Time.now %></h5>
  # Yesterday was <%= Time.now - (60 * 60 * 24) %>
  # One week ago was <%= Time.now - (60 * 60 * (24*7)) %>
  # 30 days ago was <%= Time.now - (60 * 60 * (24*30)) %>

  def create
    authenticate_anybody
    user = User.create( user_params )
    if user.save
      if user.status === 0
        session[:user_id] = user.id
      elsif user.status != 0
        redirect_to request.referrer
      end
    else
      flash[:error] = user.errors.full_messages
      redirect_to request.referrer
    end
  end

  def cart
    authenticate_anybody
    @order = Order.new
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
