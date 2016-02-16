class MoveEtaAndPlaceId < ActiveRecord::Migration
  def change
  	remove_column :users, :eta, :string
  	remove_column :users, :place_id, :string
  	add_column 	  :event_users, :eta, :string
  	add_column    :event_users, :place_id, :string
  end
end
