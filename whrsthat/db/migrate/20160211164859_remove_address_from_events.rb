class RemoveAddressFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :address, :string
  end
end
