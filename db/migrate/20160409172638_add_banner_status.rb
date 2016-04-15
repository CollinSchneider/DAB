class AddBannerStatus < ActiveRecord::Migration
  def change
    add_column :banners, :status, :string
  end
end
