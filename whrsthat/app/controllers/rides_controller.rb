class RidesController < ActionController::Base

	def uber
		Uber::Client.new do |config|
		  config.server_token  = ENV["UBER_SERVER_KEY"]
		  config.client_id     = ENV["UBER_CLIENT_ID"]
		  config.client_secret = ENV["UBER_CLIENT_SECRET"]
		end
	end

	def products
		uber.products(latitude: lat, longitude: lon)
	end

	def price 
		uber.price_estimations(start_latitude: slat, start_longitude: slon,
                         		end_latitude: dlat, end_longitude: dlon)
	end 

	def time 
		uber.time_estimations(start_latitude: slat, start_longitude: slon)
	end 

	def uber_bearer
		Uber::Client.new do |config|
		  config.server_token  = ENV["UBER_SERVER_KEY"]
		  config.client_id     = ENV["UBER_CLIENT_ID"]
		  config.client_secret = ENV["UBER_CLIENT_SECRET"]
		  config.bearer_token  = 	 "USER_ACCESS_TOKEN" 
		end
	end

	def user_info
		uber_bearer.me 
	end 

	def user_activities
		uber_bearer.history 
	end 

	def uber_ride
	  	Uber::Client.new do |config|
		  config.client_id     = ENV["UBER_CLIENT_ID"]
		  config.client_secret = ENV["UBER_CLIENT_SECRET"]
		  config.bearer_token  = 	 "USER_ACCESS_TOKEN"
		end
	end

	def requests
		@event = Event.find(params['event_id']).select('latitude', 'longitude').take 
		uber_ride.trip_request(product_id: product_id, 
								start_latitude: current_user.latitude, start_longitude: current_user.longitude, 
									end_latitude: @event.latitude, end_longitude: @event.longitude)
	end 

	def request_details
		uber_ride.trip_details 'request_id'
	end 

	def destroy 
		uber_ride.trip_cancel 'request_id'
	end 
end 