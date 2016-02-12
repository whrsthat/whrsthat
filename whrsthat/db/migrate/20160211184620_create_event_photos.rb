class CreateEventPhotos < ActiveRecord::Migration
  def change
    create_table :event_photos do |t|
      t.string :url

      t.timestamps null: false
    end
  end
end
