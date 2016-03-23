class UsersController < ApplicationController

  def index
    if current_user
      redirect_to products_path
    end
  end

  def show
    authenticate_admin
    @user = User.find(params[:id])
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

  def update_account
    # user = User.find(params[:id])
    user = current_user
    user.update(user_account_params)
    user.skip_user_validation = true
    if user.save
      flash[:success] = "Information Updated!"
    else
      flash[:error] = user.errors.full_messages
    end
    redirect_to request.referrer
  end

  def update_password
    # user = User.find(params[:id])
    user = current_user
    user.update(user_password_params)
    user.skip_user_validation = true
    if user.save
      flash[:success] = "Information Updated!"
    else
      flash[:error] = user.errors.full_messages
    end
    redirect_to request.referrer
  end

  def create
    user = User.create( user_params )
    if user.save
      if user.status === 0
        session[:user_id] = user.id
        # UserMailer.user_welcome_email(user).deliver
        redirect_to products_path
      elsif user.status === 1
        flash[:success] = "New Affiliate Created!"
        # UserMailer.affiliate_welcome_email(user).deliver
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
      @order = Order.new
      total_amount
      cart_counter
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
  def user_account_params
    params.require(:user).permit(:email, :name)
  end

  private
  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  private
  def order_params
    params.require(:order).permit(:user_id, :affiliate_id, :product_id, :shipping_number, :status)
  end

end
