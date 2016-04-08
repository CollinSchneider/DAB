class AddVideoStatus < ActiveRecord::Migration
  def change
    add_column :products, :video_status, :string
  end
end
