class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :affiliate, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.string :category
      t.string :price
      t.integer :model
      t.string :size
      t.string :picture

      t.timestamps null: false
    end
  end
end
