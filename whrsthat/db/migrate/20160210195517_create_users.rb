class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :phone
      t.string :fname
      t.string :lname_initial
      t.string :email
      t.string :prof_img_url

      t.timestamps null: false
    end
  end
end
