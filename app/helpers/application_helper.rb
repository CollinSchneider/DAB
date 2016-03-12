module ApplicationHelper

  def current_user
    if session[:user_id]
      @current_user = @current_user || User.find(session[:user_id])
    end
  end

  def current_user_address
    current_user.addresses.each do |address|
      binding.pry
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
