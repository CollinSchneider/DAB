class AddsLinkToForBanners < ActiveRecord::Migration
  def change
    add_column :banners, :link_to, :string
  end
end
