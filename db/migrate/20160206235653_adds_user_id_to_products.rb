class AddsUserIdToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :user, index: true
  end
end
