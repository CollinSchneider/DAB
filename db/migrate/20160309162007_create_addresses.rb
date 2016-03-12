class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :country
      t.string :state
      t.string :city
      t.integer :zip
      t.string :address

      t.timestamps null: false
    end
  end
end
