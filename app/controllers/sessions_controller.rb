class SessionsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.status === 0
        redirect_to root_path
      elsif user.status === 1
        redirect_to affiliates_path
      elsif user.status === 2
        redirect_to admins_path
      end
    else
      redirect_to users_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
