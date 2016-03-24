class SessionsController < ApplicationController

  def create
    user = User.find_by_email(params[:email].downcase)
    if !user
      flash[:error] = "No users found with this email"
      redirect_to users_path
    elsif user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.status === 0
        redirect_to root_path
      elsif user.status === 1
        redirect_to affiliate_path
      elsif user.status === 2
        redirect_to admins_path
      end
    else
      flash[:error] = "Incorrect password"
      redirect_to users_path
    end
  end

  def facebook_create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to users_path
  end

end
