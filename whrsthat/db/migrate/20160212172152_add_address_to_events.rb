class AddAddressToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :event_address, :string
  end
end
