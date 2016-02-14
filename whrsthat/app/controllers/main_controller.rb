class MainController < ApplicationController
	def home
		if current_user != nil
      		redirect_to '/events'
    	else
			render "home", layout: "landing"
    	end
  	end
end