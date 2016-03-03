class ChargesController < ApplicationController

	def total_price
		# product_id_array = current_user.cart_items.map { |item| item.product_id }
		# @cart = Product.find(product_id_array)
		product_prices = current_user.cart_items.map do |cart_item|
			cart_item.quantity.to_i * cart_item.product_item.product.price.to_i
		end
		# product_prices = @cart.map { |item| item.price.to_i }
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

		new_order = Order.create( :user_id => current_user.id )

		current_user.cart_items.each do |item|
			OrderItem.create(:order_id => new_order.id, :status => 0, :user_id => current_user.id, :affiliate_id => item.product_item.product.user_id, :product_item_id => item.product_item.id, :quantity => item.quantity)
			item.destroy
		end
		# current_user.cart_items.each { |item| item.destroy }

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
