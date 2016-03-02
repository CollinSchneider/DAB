class ChargesController < ApplicationController

	def total_price
		product_id_array = current_user.cart_items.map { |item| item.product_id }
		@cart = Product.find(product_id_array)
		product_prices = @cart.map { |item| item.price.to_i }
		@amount = product_prices.reduce(0, :+)
		@stripe_amount = @amount*100
	end

	def new
		total_price
	end

	def create
	  # Amount in cents
	  # @amount = 500
		total_price

		# new_order = Order.create( order_params )
		# users_cart = CartItem.where('user_id = ?', current_user)
		current_user.cart_items.each do |item|
			OrderItem.create(:status => 0, :user_id => current_user.id, :affiliate_id => item.affiliate_id, :product_id => item.product_id)
		end
		current_user.cart_items.each { |item| item.destroy }

	  customer = Stripe::Customer.create(
	    :email => params[:stripeEmail],
	    :source  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @stripe_amount,
	    :description => 'Rails Stripe customer',
	    :currency    => 'usd'
	  )

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to new_charge_path
	end

	private
	def order_params
		params.require(:order).permit(:user_id)
	end

end
