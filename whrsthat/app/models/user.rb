require "geocoder"
class User < ActiveRecord::Base
	has_many :events
	has_many :invitees, through: :events
	has_secure_password

	geocoded_by :local_ip,
  		:latitude => :lat, :longitude => :lon
	after_validation :geocode
end
