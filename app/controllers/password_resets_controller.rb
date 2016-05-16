class PasswordResetsController < ApplicationController

  def create_digest
    (0...30).map { (65 + rand(26)).chr }.join
  end

  def create
    binding.pry
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.skip_user_validation = true
      @user.reset_digest = create_digest
      @user.reset_sent_at = Time.now.strftime('%B %d, %Y; %l:%M %P')
      @user.save!
      UserMailer.password_reset(@user).deliver
      flash[:error] = "Email sent to #{@user.email} with password reset instructions"
      redirect_to root_path
    else
      flash.now[:error] = "No users with this email"
      render 'new'
    end
  end

  def update
    user = User.find_by_reset_digest(params[:id])
    time_difference = Time.now - user.reset_sent_at
    # if Time.now - 4.hours < user.reset_sent_at
      user.update(user_password_params)
      user.skip_user_validation = true
      if user.save
        session[:user_id] = user.id
        flash[:success] = "Password Updated!"
        user.reset_digest = nil
        user.reset_sent_at = nil
        user.save
        redirect_to root_path
      else
        flash[:error] = user.errors.full_messages
        redirect_to request.referrer
      end
    # end
  end

  def new
  end

  def edit
    @user = User.find_by_reset_digest(params[:id])
    if @user.reset_digest === nil
      redirect_to root_path
    end
  end

  private
  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
