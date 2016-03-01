class AddShippingNumber < ActiveRecord::Migration
  def change
    add_column :order_items, :shipping_number, :string
  end
end
