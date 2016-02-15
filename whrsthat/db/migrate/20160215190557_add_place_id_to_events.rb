class AddPlaceIdToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :place_id, :string
  end
end
