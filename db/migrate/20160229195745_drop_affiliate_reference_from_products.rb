class DropAffiliateReferenceFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :affiliate_id
  end
end
