class DropProductIdAndAddProductItemIdToCartItems < ActiveRecord::Migration
  def change
    remove_column :cart_items, :product_id
    add_reference :cart_items, :product_item, index: true
    add_foreign_key :cart_items, :product_items
  end
end
