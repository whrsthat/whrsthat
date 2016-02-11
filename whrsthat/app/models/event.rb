class Event < ActiveRecord::Base
	belongs_to :user
	has_many :invitees
	has_many :eventphotos
	mount_uploader :event_photo, EventPhotoUploader
	#validates :url, presence: true 
end
