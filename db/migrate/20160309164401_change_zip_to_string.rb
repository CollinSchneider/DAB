class ChangeZipToString < ActiveRecord::Migration
  def change
    change_column :addresses, :zip, :string
  end
end
