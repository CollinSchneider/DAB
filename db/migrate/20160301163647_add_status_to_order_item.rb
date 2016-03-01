class AddStatusToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :status, :integer
  end
end
