class ChangeToProducItemIdInOrderItems < ActiveRecord::Migration
  def change
    remove_column :order_items, :product_id
    add_reference :order_items, :product_item, index: true
    add_foreign_key :order_items, :product_items
  end
end
