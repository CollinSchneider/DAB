class AddMetaTagColumnToProduct < ActiveRecord::Migration
  def change
    add_column :products, :meta_keyword, :string
  end
end
