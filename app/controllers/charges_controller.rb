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

	def current_user_address
		@current_user_address = current_user.addresses.where('active = ?', 'yes')
	end

	def tax_rate
		total_price
		current_user_address
		# client = Taxjar::Client.new(api_key: '3f169a7225ca6da1b9b743d28b17af7a')
		# @rate = client.rates_for_location(@current_user_address[0].zip, {
		# 	:city => @current_user_address[0].city
		# 	})
		# if @rate == nil
		# 	flash[:error] = "Cannot find address, please update or use a different address."
		# end
	end

	def new
		total_price
		cart_counter
		current_user_address
		tax_rate
		@new_address = Address.new
	end

	def create
		cart_counter
	  # Amount in cents
	  # @amount = 500
		total_price
		tax_rate
		current_user_address
		# '%.0f' % (@stripe_amount*(1+@rate.combined_rate)
		# if current_user.addresses.length == 0
		# 	flash[:error] = "Must fill out shipping address before checking out!"
		# 	redirect_to profile_path
		# else
			new_order = Order.create( :user_id => current_user.id, :address_id => @current_user_address[0].id, :pre_tax_total => @amount)

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

		# end

		rescue Stripe::CardError => e
		  flash[:error] = e.message
		  redirect_to new_charge_path
		end

	private
	def order_params
		params.require(:order).permit(:user_id, :address_id, :pre_tax_total, :tax_amount)
	end

end
