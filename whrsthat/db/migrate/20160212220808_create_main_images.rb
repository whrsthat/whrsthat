class CreateMainImages < ActiveRecord::Migration
  def change
    create_table :main_images do |t|
      t.string :url
      t.string :format

      t.timestamps null: false
    end
  end
end
