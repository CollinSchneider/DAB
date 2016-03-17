class AddAlternateImagesAttachment < ActiveRecord::Migration
  def change
    add_attachment :products, :image_two
    add_attachment :products, :image_three
    add_attachment :products, :image_four
    add_attachment :products, :image_five
  end
end
