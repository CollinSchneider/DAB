class AddOrderTotals < ActiveRecord::Migration
  def change
    add_column :orders, :pre_tax_total, :string
    add_column :orders, :tax_amount, :string
  end
end
