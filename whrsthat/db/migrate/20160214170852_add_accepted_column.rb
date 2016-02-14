class AddAcceptedColumn < ActiveRecord::Migration
  def change
  	add_column :event_users, :accepted, :boolean
  end
end
