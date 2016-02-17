require 'net/http'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #if special token missing will fail
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by_id(session[:user])
  end

  def profile
    uri = URI.parse('https://sandbox-api.uber.com/v1/me')

    request = Net::HTTP::Get.new( uri )
    request['Authorization'] = "Bearer #{params[:access_token]}"
    puts request['Authorization']
    response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) {|http|
      http.request(request)
    }

    render json: response.body
  end

 	def twilio 
		account_sid = ENV['TWILIO_SID']
		auth_token = ENV['TWILIO_AUTH_TOKEN']

		 Twilio::REST::Client.new account_sid, auth_token
	end

end
