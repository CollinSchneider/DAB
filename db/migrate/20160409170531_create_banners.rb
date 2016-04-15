class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
