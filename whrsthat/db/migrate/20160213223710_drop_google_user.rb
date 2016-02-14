class DropGoogleUser < ActiveRecord::Migration
  def change
  	drop11_table :google_users
  end
end
