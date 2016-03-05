class AddProductItemTable < ActiveRecord::Migration
  def change
    create_table :product_items do |t|
      t.references :product, index: true, foreign_key: true
      t.string :description
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
