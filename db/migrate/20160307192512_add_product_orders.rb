class AddProductOrders < ActiveRecord::Migration
  def change
    add_column :products, :total_orders, :integer
  end
end
