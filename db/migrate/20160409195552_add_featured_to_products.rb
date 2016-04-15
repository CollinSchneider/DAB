class AddFeaturedToProducts < ActiveRecord::Migration
  def change
    add_column :products, :featured, :string
  end
end
