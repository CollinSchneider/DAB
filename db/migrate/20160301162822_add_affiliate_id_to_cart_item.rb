class AddAffiliateIdToCartItem < ActiveRecord::Migration
  def change
    add_column :cart_items, :affiliate_id, :integer
  end
end
