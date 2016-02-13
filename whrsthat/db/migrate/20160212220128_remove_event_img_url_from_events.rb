class RemoveEventImgUrlFromEvents < ActiveRecord::Migration
  def change
  	remove_column :events, :event_img_url, :string
  end
end
