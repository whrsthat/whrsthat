class MakeUsersUnique < ActiveRecord::Migration
  def change
  	add_index :users, [:phone, :email], unique: true
  end
end
