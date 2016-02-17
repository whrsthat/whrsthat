class AddHostEta < ActiveRecord::Migration
  def change
  	add_column :events, :eta, :string
  end
end
