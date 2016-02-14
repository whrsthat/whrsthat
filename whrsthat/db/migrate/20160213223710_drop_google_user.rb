class DropGoogleUser < ActiveRecord::Migration
  def change
  	drop_table :google_users
  end
end
