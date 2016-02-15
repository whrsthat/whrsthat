class Eventusernumber < ActiveRecord::Migration
  def change
  	add_column :event_users, :number, :string	
  end
end
