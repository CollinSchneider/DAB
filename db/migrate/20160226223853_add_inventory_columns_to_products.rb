class AddInventoryColumnsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :total_quantity, :integer
    add_column :products, :XS_quantity, :integer
    add_column :products, :S_quantity, :integer
    add_column :products, :M_quantity, :integer
    add_column :products, :L_quantity, :integer
    add_column :products, :XL_quantity, :integer
    add_column :products, :XXL_quantity, :integer
  end
end
