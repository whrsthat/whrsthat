class ChangeLatLongColumnName < ActiveRecord::Migration
  def change
  	rename_column :events, :lng, :longitude
  	rename_column :events, :lat, :latitude
  end
end
