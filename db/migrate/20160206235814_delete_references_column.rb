class DeleteReferencesColumn < ActiveRecord::Migration
  def change
    remove_column :products, :references
  end
end
