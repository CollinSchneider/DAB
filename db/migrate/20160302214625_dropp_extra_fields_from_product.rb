class DroppExtraFieldsFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :total_quantity
    remove_column :products, :XS_quantity
    remove_column :products, :S_quantity
    remove_column :products, :M_quantity
    remove_column :products, :L_quantity
    remove_column :products, :XL_quantity
    remove_column :products, :XXL_quantity
  end
end
