class AddStatusToProductItem < ActiveRecord::Migration
  def change
    add_column :product_items, :status, :integer
  end
end
