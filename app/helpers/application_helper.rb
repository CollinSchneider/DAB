module ApplicationHelper

  def current_user
    if session[:user_id]
      @current_user = @current_user || User.find(session[:user_id])
    end
  end

  def store_last_location
    session[:previous_url] = request.fullpath
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
