class UserMailer < ApplicationMailer
  default from: "CollinThomasSchneider@yahoo.com"

  def welcome_email(user)
    @user = user
    @url = "http://localhost:3000"
    mail(to: @user.email, subject: 'Testing welcome')
  end

  def low_inventory_email(user, product_item)
    @user = user
    @product_item = product_item
    mail(to: @user.email, subject: "Low inventory on dealbaked")
  end

end
