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
		@current_user_address = current_user.addresses.where('active = ?', 'yes')
		@new_address = Address.new
	end

	def create
	  # Amount in cents
	  # @amount = 500
		total_price
		@current_user_address = current_user.addresses.where('active = ?', 'yes')

		if current_user.addresses.length == 0
			flash[:error] = "Must fill out shipping address before checking out!"
			redirect_to profile_path
		else
			new_order = Order.create( :user_id => current_user.id, :address_id => @current_user_address[0].id )

			current_user.cart_items.each do |item|
				order_item = OrderItem.create(:order_id => new_order.id, :status => 0, :user_id => current_user.id, :affiliate_id => item.product_item.product.user_id, :product_item_id => item.product_item.id, :quantity => item.quantity)
				product = order_item.product_item.product
				product.total_orders += item.quantity
				product.save
				item.destroy
			end

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

		end

		rescue Stripe::CardError => e
		  flash[:error] = e.message
		  redirect_to new_charge_path
		end

	private
	def order_params
		params.require(:order).permit(:user_id)
	end

end
