class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :product_id
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
