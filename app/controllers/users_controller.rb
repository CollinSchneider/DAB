class UsersController < ApplicationController

  def index
    @user = User.new
    @users = User.all
  end

  def create
    user = User.create( user_params )
    if user.save
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = user.errors.full_messages
      redirect_to users_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

end
