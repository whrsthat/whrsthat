class MakeTimeAtDate < ActiveRecord::Migration
  def change
  	remove_column :events, :time_at
  	add_column :events, :time_at, :timestamp
  end
end
