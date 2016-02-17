class UberAccessToken < ActiveRecord::Migration
  def change
  	add_column :users, :uber_access_token, :string
  end
end
