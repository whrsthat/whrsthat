class ScheduledEventBool < ActiveRecord::Migration
  def change
  	add_column :events, :scheduled, :boolean
  end
end
