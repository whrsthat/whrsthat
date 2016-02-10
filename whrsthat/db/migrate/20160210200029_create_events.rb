class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :caption
      t.string :time_at
      t.string :event_img_url
      t.integer :lng
      t.integer :lat

      t.timestamps null: false
    end
  end
end
