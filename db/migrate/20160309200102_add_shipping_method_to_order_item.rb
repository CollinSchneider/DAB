class AddShippingMethodToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :shipping_method, :string
  end
end
