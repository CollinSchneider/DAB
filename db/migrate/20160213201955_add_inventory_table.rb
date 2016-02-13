class AddInventoryTable < ActiveRecord::Migration
  def change
    create_table :inventory do |t|
      t.references :product, index: true, foreign_key: true
      t.string :size
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
