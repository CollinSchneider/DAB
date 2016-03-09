class AddShippingAddressToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_name, :string
    add_column :orders, :country, :string
    add_column :orders, :state, :string
    add_column :orders, :city, :string
    add_column :orders, :zip, :string
    add_column :orders, :address, :string
  end
end
