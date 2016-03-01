class AddOrderItemTable < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :order, index: true, foreign_key: true
      t.integer :product_id
      t.integer :user_id
      t.integer :affiliate_id

      t.timestamps null: false
    end
  end
end
