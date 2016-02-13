class MainController < ApplicationController
	def home
		render "home", layout: "landing"
  	end

  	def contact
  	end
end