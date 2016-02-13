class OrdersController < ApplicationController

  def index
    authenticate_user
    @orders = Order.all
  end

end
