class User < ActiveRecord::Base
	has_many :events
	has_many :invitees, through: :events
	has_secure_password
	validates_uniqueness_of :email
	validates_uniqueness_of	 :phone

	def name 
		"#{self.fname} #{self.lname_initial}"
	end

	def eta(invite)
    google_server_key = ENV['GOOGLE_SERVER_KEY']
    google_uri = URI("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{invite.user.latitude},#{invite.user.longitude}&key=#{google_server_key}")
    result = Net::HTTP.get(google_uri)
    google_user_location_data = JSON.parse(result)

    invite_place_id = google_user_location_data.flatten[1][0]["place_id"]
    invite.update_attributes(:place_id => invite_place_id)
    invite_eta = URI("https://maps.googleapis.com/maps/api/directions/json?origin=place_id:#{invite_place_id}&destination=place_id:#{invite.event.place_id}&mode=transit&transit_mode=subway&key=#{google_server_key}")
    eta_result  = Net::HTTP.get(invite_eta)
    eta_parsed = JSON.parse(eta_result)
    begin
   		arrival_time = eta_parsed.flatten[3][0]["legs"][0]["arrival_time"]["text"]
   	rescue
   		arrival_time = 'ETA could not be determined'
   	end

    invite.update_attributes(:eta => arrival_time)
	end

	def host_eta(event)
    google_server_key = ENV['GOOGLE_SERVER_KEY']
    google_uri = URI("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{self.latitude},#{self.longitude}&key=#{google_server_key}")
    result = Net::HTTP.get(google_uri)
    google_user_location_data = JSON.parse(result)

    invite_place_id = google_user_location_data.flatten[1][0]["place_id"]

    invite_eta = URI("https://maps.googleapis.com/maps/api/directions/json?origin=place_id:#{invite_place_id}&destination=place_id:#{event.place_id}&mode=transit&transit_mode=subway&key=#{google_server_key}")
    eta_result  = Net::HTTP.get(invite_eta)
    eta_parsed = JSON.parse(eta_result)

    begin
   		arrival_time = eta_parsed.flatten[3][0]["legs"][0]["arrival_time"]["text"]
   	rescue
   		arrival_time = 'ETA could not be determined'
   	end
   	event.update_attributes(:eta => arrival_time)
	end
end
