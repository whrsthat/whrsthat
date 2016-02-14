class AddIpToUser < ActiveRecord::Migration
  def change
  	add_column :users, :local_ip, :string
  	add_column :users, :lat, :float
  	add_column :users, :lon, :float
  end
end
