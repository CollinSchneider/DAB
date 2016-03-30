class OverallMetricsPdf < Prawn::Document

  def initialize(total_impressions, total_unique_views, total_sales, total_orders, total_show_impressions, weeks_impressions, weeks_show_impressions, weeks_unique_views, orders_7_days, sales_7_days, weeks_orders, top_selling_week_product, top_selling_affiliate, top_selling_products)
    super()
    @total_impressions = total_impressions
    @total_unique_views = total_unique_views
    @total_sales = total_sales
    @total_orders = total_orders
    @total_show_impressions = total_show_impressions
    @weeks_impressions = weeks_impressions
    @weeks_show_impressions = weeks_show_impressions
    @weeks_unique_views = weeks_unique_views
    @orders_7_days = orders_7_days
    @sales_7_days = sales_7_days
    @weeks_orders = weeks_orders
    @top_selling_week_product = top_selling_week_product
    @top_selling_affiliate = top_selling_affiliate
    @top_selling_products = top_selling_products
    header
    overall_metrics
    weeks_metrics
    weeks_orders_view
    top_products
  end

  def header
    text "DealBaked Metrics as of #{Time.now.strftime('%B %d, %Y; %l:%M %p')}", size: 20, style: :bold, align: :center
  end

  def overall_metrics
    text "Overall Metrics", size: 16, style: :bold, align: :center
    text "Total Impressions: #{ @total_impressions.count }"
    text "Total Unique Visitors: #{ @total_unique_views.count }"
    text "Total Sales: $#{ @total_sales }"
    text "Total Conversion Rate: #{ '%.3f' % ((@total_orders.to_f/@total_show_impressions.count)*100) }%"
  end

  def weeks_metrics
    text "#{(Time.now - (60 * 60 * (24*7))).strftime('%b %d, %Y')} to #{ Time.now.strftime('%b %d, %Y')}", size: 16, style: :bold, align: :center
    text "Impressions: #{ @weeks_impressions.count }"
    text "Sales: $#{ @sales_7_days }"
    text "Unique Visitors: #{ @weeks_unique_views.count }"
    text "Conversion Rate: #{ '%.3f' % ((@orders_7_days.to_f/@weeks_show_impressions.count)*100) }%"
  end

  def weeks_orders_view
    text "Weeks Orders", size: 16, style: :bold, align: :center
    text "Total Orders: #{@weeks_orders}"
    text "Products Sold: #{ @orders_7_days }"
    if @top_selling_affiliate != nil
      text "Top Product: #{ @top_selling_week_product[0] }: #{ @top_selling_week_product[1]} sales"
    else
      text "Top Product: No products sold this week!"
    end
    if @top_selling_affiliate != nil
      text "Top Affiliate: #{ @top_selling_affiliate[0] }: #{ @top_selling_affiliate[1] } sales"
    else
      text "Top Affiliate: No sales this week!"
    end
  end

  def top_products
    text "Top Selling Products", size: 16, style: :bold, align: :center
    @top_selling_products.each do |product|
      Prawn::Document.generate("image2.pdf", :page_layout => :landscape) do
        picture = "#{Prawn::BASEDIR}#{product.image.url(:thumb)}"
        image = picture
      end
      text "#{product.title}: #{product.total_orders} orders"
    end
  end

end
