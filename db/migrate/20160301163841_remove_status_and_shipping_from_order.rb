class RemoveStatusAndShippingFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :shipping_number
    remove_column :orders, :status
  end
end
