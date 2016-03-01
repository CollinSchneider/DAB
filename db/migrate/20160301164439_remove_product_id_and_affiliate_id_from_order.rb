class RemoveProductIdAndAffiliateIdFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :affiliate_id
    remove_column :orders, :product_id
  end
end
