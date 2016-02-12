class MakeFloat < ActiveRecord::Migration
  def change
  	change_column :events, :lat, :float
  	change_column :events, :lng, :float
  end
end
