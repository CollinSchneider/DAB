class AddAdminNotesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :admin_notes, :string
  end
end
