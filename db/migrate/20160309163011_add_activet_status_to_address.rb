class AddActivetStatusToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :active, :string
  end
end
