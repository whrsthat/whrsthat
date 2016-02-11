class Event < ActiveRecord::Base
	belongs_to :user
	has_many :invitees
	mount_uploader :event_photo, EventPhotoUploader
	#validates :url, presence: true 
end
