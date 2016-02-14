class EditUserLatLon < ActiveRecord::Migration
  def change
  	rename_column :users, :lon, :longitude
  	rename_column :users, :lat, :latitude
  end
end
