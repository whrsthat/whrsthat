# require 'open-uri'
require 'pry'
class Event < ActiveRecord::Base
	belongs_to :user
	has_many :invitees
	has_many :event_photos
	#validates :url, presence: true 
	attr_accessor :photo
	#what is attr_accessor doing here and how does it work with the strong params?

	after_save do
		if !self.lat && !self.lng
	        photo_data = EXIFR::JPEG.new(@photo.path).exif
	        lat = photo_data.gps_latitude[0].to_f + (photo_data.gps_latitude[1].to_f / 60) + (photo_data.gps_latitude[2].to_f / 3600)
	        long = photo_data.gps_longitude[0].to_f + (photo_data.gps_longitude[1].to_f / 60) + (photo_data.gps_longitude[2].to_f / 3600)
	        self.lng = ((photo_data.gps_longitude_ref == "W") ? (long * -1) : long)    # (W is -, E is +)
	        self.lat = ((photo_data.gps_latitude_ref == "S") ? (lat * -1) : lat)      # (N is +, S is -)

	        FileUtils.cp(@photo.path, "public/photos/#{id}.jpg")

	        google_server_key = ENV['GOOGLE_SERVER_KEY']
	 		google_uri = URI("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{self.lat},#{self.lng}&key=#{google_server_key}")
	        result = Net::HTTP.get(google_uri)
	        google_photo_data = JSON.parse(result)
			event_address = google_photo_data.flatten[1][0]["formatted_address"]
			self.update_attributes(:event_address => event_address)

			self.save()
		end
	end
end
