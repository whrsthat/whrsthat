class RidesController < ActionController::Base
	def current_user
		@current_user ||= User.find_by_id(session[:user])
	end

	def uber
		Uber::Client.new do |config|
			config.sandbox = true
		  config.server_token  = ENV["UBER_SERVER_KEY"]
		  config.client_id     = ENV["UBER_CLIENT_ID"]
		  config.client_secret = ENV["UBER_CLIENT_SECRET"]
		end
	end

	def event
		@event = Event.find(params['event_id'])
	end

	def products
		@products = uber.products(latitude: event.latitude, longitude: event.longitude)
		render json: @products
	end



	def price 
		prices = uber.price_estimations(start_latitude: current_user.latitude, start_longitude: current_user.longitude,
                         		end_latitude: event.latitude , end_longitude: event.longitude)

		render json: prices
	end 

	def time 
		uber.time_estimations(start_latitude: current_user.latitude, start_longitude: current_user.longitude)
	end 

	def uber_create
		access_token = request.env['omniauth.auth']['credentials']['token']
		current_user.uber_access_token = access_token
		current_user.save()
		if session[:last_event]
			redirect_to("/events/#{session[:last_event]}")
		else
			redirect_to("/events")
		end
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
		render 'events/show'
	end 

	def user_activities
		uber_bearer.history 
	end 

	def uber_ride
	  	Uber::Client.new do |config|
		  config.client_id     = ENV["UBER_CLIENT_ID"]
		  config.client_secret = ENV["UBER_CLIENT_SECRET"]
		  config.bearer_token  = 	 "USER_ACCESS_TOKEN"
		  config.sandbox = true
		end
	end

	def requests
		# @event = Event.find(params['event_id']).select('latitude', 'longitude').take 
		@request = uber_ride.trip_request(product_id: params[:product_id], 
								start_latitude: current_user.latitude, start_longitude: current_user.longitude, 
									end_latitude: event.latitude, end_longitude: event.longitude)
		
		render :nothing => true, :status => 204
	end 

	def request_details
		uber_ride.trip_details 'request_id'
	end 

	def destroy 
		uber_ride.trip_cancel 'request_id'
	end 
end 