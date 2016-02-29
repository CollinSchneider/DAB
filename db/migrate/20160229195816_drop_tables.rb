class DropTables < ActiveRecord::Migration
  def change
    drop_table :affiliates
    drop_table :admins
    drop_table :inventories
  end
end
