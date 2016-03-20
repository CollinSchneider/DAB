class UserMailer < ApplicationMailer
  default from: "CollinThomasSchneider@yahoo.com"

  def user_welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to DealBaked!')
  end

  def affiliate_welcome_email(affiliate)
    @user = affiliate
    mail(to: @user.email, subject: "Welcome to DealBaked!")
  end

  def low_inventory_email(user, product_item)
    @user = user
    @product_item = product_item
    mail(to: @user.email, subject: "Low inventory on DealBaked")
  end

  def purchase_confirmation_email(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: "DealBaked Order")
  end

end
