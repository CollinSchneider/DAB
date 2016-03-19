module ApplicationHelper

  def current_user
    if session[:user_id]
      @current_user = @current_user || User.find(session[:user_id])
    end
  end

  def cart_counter
    if current_user != nil
      cart_quantity = []
      current_user.cart_items.each do |item|
        cart_quantity.push(item.quantity)
      end
      @cart_quantity = cart_quantity.reduce(:+)
    end
  end

    def calc_tax_rate
      if current_user != nil && @current_user_address[0] != nil
        client = Taxjar::Client.new(api_key: '3f169a7225ca6da1b9b743d28b17af7a')
        @rate = client.rates_for_location(@current_user_address[0].zip, {
          :city => @current_user_address[0].city
        })
      end
    end

  def current_user_address
    if current_user != nil
      @current_user_address = current_user.addresses.where('active = ?', 'yes')
    end
  end

  def past_24_hours
    Time.now.utc - (60 * 60 * 24)
  end

  def past_7_days
    Time.now.utc - (60 * 60 * (24*7))
  end

  def past_30_days
    Time.now.utc - (60 * 60 * (24*30))
  end

  def authenticate_anybody
    redirect_to users_path unless current_user
  end

  def authenticate_user
    redirect_to users_path unless current_user
    if current_user
      redirect_to root_path unless current_user.status === 0
    end
  end

  def authenticate_affiliate
    redirect_to users_path unless current_user
    if current_user
      redirect_to root_path unless current_user.status === 1
    end
  end

  def authenticate_admin
    redirect_to users_path unless current_user
    if current_user
      redirect_to root_path unless current_user.status === 2
    end
  end

end
