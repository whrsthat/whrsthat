class AddEventToMainImage < ActiveRecord::Migration
  def change
    add_reference :main_images, :event, index: true, foreign_key: true
  end
end
