class AdminsController < ApplicationController

  def index
    authenticate_admin
    @total_impressions = Impression.where('action_name = ?', 'index')
    @total_unique_views = Impression.select(:ip_address).uniq
    @weeks_unique_views = @total_unique_views.where('created_at >= ?', past_7_days)
    @total_show_impressions = Impression.where('action_name = ?', 'show')
    @weeks_impressions = Impression.where('action_name = ? AND created_at >= ?', 'index', past_7_days)
    @weeks_show_impressions = Impression.where('action_name = ? AND created_at >= ?', 'show', past_7_days)
    @top_selling_products = Product.order(total_orders: :desc).limit(4)
    @weeks_orders = Order.where('created_at >= ?', past_7_days).count

    total_orders = OrderItem.all
    @total_orders = 0
    @total_sales = 0
    @orders_24_hours = 0
    @sales_24_hours = 0
    @orders_7_days = 0
    @sales_7_days = 0
    @orders_30_days = 0
    @sales_30_days = 0
    affiliate_week_sales = {}
    top_selling_week_product_array = {}

    total_orders.each do |item|
      @total_orders += item.quantity
      @total_sales += item.product_item.product.price.to_i * item.quantity

      if item.created_at >= past_24_hours

        @orders_24_hours += item.quantity
        @sales_24_hours += item.product_item.product.price.to_i * item.quantity

      end
      if item.created_at >= past_7_days

        get_top_selling_product(top_selling_week_product_array, item.quantity, item.product_item.product.title)
        get_top_selling_affiliate(affiliate_week_sales, item.product_item.product.user.email, item.product_item.product.price.to_i, item.quantity)

        @orders_7_days += item.quantity
        @sales_7_days += item.product_item.product.price.to_i * item.quantity

      end
      if item.created_at >= past_30_days

        @orders_30_days += item.quantity
        @sales_30_days += item.product_item.product.price.to_i * item.quantity
      end

    end
  end

  def get_top_selling_product(array, quantity, title)
    if array[title] === nil
      array[title] = quantity
    else
      array[title] += quantity
    end
    @top_selling_week_product = array.max_by{|a,b| a}
  end

  def get_top_selling_affiliate(array, email, price, quantity)
    if array[email] === nil
      array[email] = price * quantity
    else
      array[email] += price * quantity
    end
    @top_selling_affiliate = array.max_by{|a,b| a}
  end

  def orders
    @weeks_orders = Order.where('created_at >= ?', past_7_days)
    @weeks_pending_orders = OrderItem.where('created_at >= ? AND status = ?', past_7_days, 0)
    @weeks_delivered_orders = OrderItem.where('created_at >= ? AND status = ?', past_7_days, 1)
    @affiliates = User.order('name').where(status: 1)

    if params[:search]
      @affiliates = User.where('name LIKE ? AND status = ?', "%#{params[:search]}%", 1)
    else
      @affiliates = User.where('status = ?', 1)
    end

    affiliate_order_hash = {}
    @affiliates.each do |affiliate|
      affiliate.products.each do |product|
        product.product_items.each do |item|
          item.order_items.each do |order|
            if order.status === 0
              if affiliate_order_hash[order.product_item.product.user.name] === nil
                affiliate_order_hash[order.product_item.product.user.name] = 1
              else
                affiliate_order_hash[order.product_item.product.user.name] += 1
              end
            end
            # if order.status === 0
            #   if affiliate_order_hash[order.product_item.product.user.name][order.status] != nil
            #     affiliate_order_hash[order.product_item.product.user.name][order.status] += 1
            #   else
            #     affiliate_order_hash[order.product_item.product.user.name][order.status] = 1
            #   end
            # elsif order.status === 1
            #   if affiliate_order_hash[order.product_item.product.user.name][order.status.to_s] === nil
            #     affiliate_order_hash[order.product_item.product.user.name][order.status.to_s] = 1
            #   else
            #     affiliate_order_hash[order.product_item.product.user.name][order.status.to_s] += 1
            #   end
            # elsif order.status === 2
            #   if affiliate_order_hash[order.product_item.product.user.name][order.status] === nil
            #     affiliate_order_hash[order.product_item.product.user.name][order.status] = 1
            #   else
            #     affiliate_order_hash[order.product_item.product.user.name][order.status] += 1
            #   end
            # end
            @affiliate_orders = affiliate_order_hash
          end
        end
      end
    end
  end

  def update_affiliate_orders
    id = params['affiliate_id'].to_i
    @affiliates_orders = OrderItem.where('created_at >= ? AND affiliate_id = ? ', past_7_days, id)
    @affiliates_pending_orders = OrderItem.where('created_at >= ? AND status = ? AND affiliate_id = ?', past_7_days, 0, id)
    @affiliates_delivered_orders = OrderItem.where('created_at >= ? AND status = ? AND affiliate_id = ?', past_7_days, 1 ,id)
    data = {:all => @affiliates_orders, :pending => @affiliates_pending_orders, :delivered => @affiliates_delivered_orders}
    respond_to do |format|
      format.json { render :json => data }
    end
  end

  def products
    @affiliates = User.where('status = ?', 1)
  end

  def users
    @total = User.where(status: 0).length
    @begining_of_week = User.where('created_at >= ? AND status = ? ', Time.zone.now.beginning_of_week, 0).length
    @begining_of_month = User.where('created_at >= ? AND status = ? ', Time.zone.now.beginning_of_month, 0).length
    @begining_of_year = User.where('created_at >= ? AND status = ? ', Time.zone.now.beginning_of_year, 0).length
    if params[:search]
      @users = User.where('name LIKE ? AND status = ?', "%#{params[:search]}%", 0)
    else
      @users = User.where('status = ?', 0)
    end
  end

  def affiliates
    @total = User.where(status: 1).length
    @begining_of_week = User.where('created_at >= ? AND status = ? ', Time.zone.now.beginning_of_week, 1).length
    @begining_of_month = User.where('created_at >= ? AND status = ? ', Time.zone.now.beginning_of_month, 1).length
    @begining_of_year = User.where('created_at >= ? AND status = ? ', Time.zone.now.beginning_of_year, 1).length
  end

  def updated
    product = Product.find(params[:product_id])
    product.update(product_params)
    redirect_to request.referrer
  end


end
