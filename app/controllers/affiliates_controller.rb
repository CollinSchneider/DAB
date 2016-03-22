class AffiliatesController < ApplicationController

  def index
    authenticate_affiliate
    @total_orders = 0
    @total_products_sold = 0
    @total_sales = 0
    @total_views = 0
    @weeks_views = 0
    todays_orders = []
    weeks_orders = []
    months_orders = []
    total_order_hash = {}
    @total_orders = 0
    @weeks_orders = 0
    @top_selling_products = current_user.products.order(total_orders: :desc).limit(4)
    # product_views_hash = {}
    top_product_hash = {}

    current_user.products.each do |product|
      @total_views += product.impressionist_count
      product.impressions.each do |impression|
        if impression.created_at >= past_7_days
          @weeks_views += 1
        end
      end
      product.product_items.each do |item|
        item.order_items.each do |order|
          @total_products_sold += order.quantity
          @total_sales += order.product_item.product.price.to_i * order.quantity

          if order.created_at >= past_24_hours
            todays_orders.push(order)
            weeks_orders.push(order)
            months_orders.push(order)

          elsif order.created_at >= past_7_days
            weeks_orders.push(order)
            months_orders.push(order)

            if top_product_hash[order.product_item.product.title] === nil
              top_product_hash[order.product_item.product.title] = order.quantity
            else
              top_product_hash[order.product_item.product.title] += order.quantity
            end
            @weeks_top_product = top_product_hash.max_by{|a,b| a}

          elsif order.created_at >= past_30_days
            months_orders.push(order)
          end
          if total_order_hash[order.order.id] === nil
            @total_orders += 1
            if order.order.created_at >= past_7_days
              @weeks_orders += 1
            end
          end
        end
      end
    end
    todays_sales = todays_orders.map { |item| item.product_item.product.price.to_i * item.quantity }
    @todays_sales = todays_sales.reduce(:+)
    todays_orders = todays_orders.map { |order| order.quantity }
    @todays_products_sold = todays_orders.reduce(:+)
    weeks_sales = weeks_orders.map{ |item| item.product_item.product.price.to_i * item.quantity }
    @weeks_sales = weeks_sales.reduce(:+)
    weeks_orders = weeks_orders.map { |order| order.quantity }
    @weeks_products_sold = weeks_orders.reduce(:+)
    months_sales = months_orders.map{ |item| item.product_item.product.price.to_i * item.quantity }
    @months_sales = months_sales.reduce(:+)
    months_orders = months_orders.map { |order| order.quantity }
    @months_products_sold = months_orders.reduce(:+)
  end

  def products
  end

  def update
    @pending_orders = OrderItem.where('affiliate_id = ? AND status = ?', current_user.id, 1)
  end

  def orders
    @all_order_items = OrderItem.where('affiliate_id = ?', current_user.id)
    @pending_order_items = OrderItem.where('affiliate_id = ? AND status = ?', current_user.id, 0)
    @shipped_order_items = OrderItem.where('affiliate_id = ? AND status = ?', current_user.id, 1)
    @delivered_order_items = OrderItem.where('affiliate_id = ? AND status = ?', current_user.id, 2)
  end

end
