class OrdersController < ApplicationController

  def index
    authenticate!
    @orders = Order.all
  end

end
