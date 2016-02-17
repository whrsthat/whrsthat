class MainController < ApplicationController
	def home
	# if current_user != nil
  #     		redirect_to '/events'
  #   end
  	@homepage = true
  	end
end