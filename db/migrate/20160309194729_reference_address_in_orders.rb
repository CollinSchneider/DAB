class ReferenceAddressInOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :shipping_name, :string
    remove_column :orders, :country, :string
    remove_column :orders, :state, :string
    remove_column :orders, :city, :string
    remove_column :orders, :zip, :string
    remove_column :orders, :address, :string
    add_column :orders, :address_id, :integer
  end
end
