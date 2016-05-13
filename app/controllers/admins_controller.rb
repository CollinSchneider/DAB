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
    @month_views = Impression.where('action_name = ? And created_at >= ?', 'index', Time.now - 30.days)

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

  @users = User.all
  respond_to do |format|
    format.html
    format.csv do
      headers['Content-Disposition'] = "attachment; filename=\"user-list\""
      headers['Content-Type'] ||= 'text/csv'
    end
  end
  end

  def orders
    # Calculate Month Orders
    @month_orders = Order.where('created_at >= ?', Time.now - 30.days).count
    @month_orders_data = Order.where('created_at >= ?', Time.now - 30.days)

    # Calulate Month Sales
    @month_sales = 0;
    month_orders = OrderItem.where('extract(month from created_at) = ?', Date.today.month)
    month_orders.each do |order_item|
      @month_sales += order_item.product_item.product.price.to_i * order_item.quantity
    end

    # if params[:search]
    #   @order_search = Order.where('id = ?', "#{params[:search]}").paginate(:page => params[:page], :per_page => 5)
    # end

  end

  def affiliates
    # Calculate Total Affiliates
    @total_affiliates = User.where('status = ?', 1).count

    # All Affiliates
    @all_affiliates = User.where('status = ?', 1)

    # Calculate New Affilaites For Current Month
    @total_month = User.where('created_at >= ? AND status = ? ', Time.zone.now.beginning_of_month, 1).length

    # Calculate Total Affiliates For Current Year
    @total_year = User.where('created_at >= ? AND status = ? ', Time.zone.now.beginning_of_year, 1).length

    if params[:search]
      @affiliates = User.where('name LIKE ? AND status = ? OR email like ? AND status = ?', "%#{params[:search].downcase}%", 1, "%#{params[:search].downcase}%", 1).order(:name).paginate(:page => params[:page], :per_page => 2)
    else
      @affiliates = User.where('status = ?', 1).order(:name).paginate(:page => params[:page], :per_page => 2)
    end
  end

  def users
    # Calculate Total Users
    @total_users = User.where(status: 0).count

    # All Users
    @all_users = User.where(status: 0).order(email: :asc)

    # Calculate New Users for Current Month
    @total_month = User.where('created_at >= ? AND status = ? ', Time.zone.now.beginning_of_month, 0).length

    # Calculate Total Users For Current Year
    @total_year = User.where('created_at >= ? AND status = ? ', Time.zone.now.beginning_of_year, 0).length
    if params[:search]
      @users = User.where('name LIKE ? AND status = ? OR email like ? AND status = ?', "%#{params[:search].downcase}%", 0, "%#{params[:search].downcase}%", 0).order(:name).paginate(:page => params[:page], :per_page => 5)
    else
      @users = User.where('status = ?', 0).order(:name).paginate(:page => params[:page], :per_page => 5)
    end
  end

  def products
    @total_products = Product.all.count
    @total_month = Product.where('created_at >=', Time.zone.now.beginning_of_month)
    @all_products = Product.all
    @affiliates = User.where('status = ?', 1)
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

  def updated
    product = Product.find(params[:product_id])
    product.update(product_params)
    redirect_to request.referrer
  end

  def editing
    @banner = Banner.new
    @banners = Banner.all
  end

end
