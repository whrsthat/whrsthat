class AddEtaToUser < ActiveRecord::Migration
  def change
  	add_column :users, :eta, :string
  	add_column :users, :place_id, :string
  end
end
