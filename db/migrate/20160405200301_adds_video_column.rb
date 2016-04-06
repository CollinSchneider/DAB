class AddsVideoColumn < ActiveRecord::Migration
  def change
    add_column :products, :embedded_video, :string
  end
end
