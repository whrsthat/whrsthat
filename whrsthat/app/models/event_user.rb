require 'twilio-ruby'

class EventUser < ActiveRecord::Base
	has_many :users
	belongs_to :event
	validates :number, uniqueness: { scope: :event_id, message: 'One number per event invite' }

	def event
		Event.find(self.event_id)
	end

	def user
		(self.user_id && User.find(self.user_id)) || nil
	end

	def event_author 
		User.find(event.user_id)
	end

	def set_default_values
		self.accepted ||= false
	end

	def twilio 
		account_sid = ENV['TWILIO_SID']
		auth_token = ENV['TWILIO_AUTH_TOKEN']

		@twilio ||= Twilio::REST::Client.new account_sid, auth_token
	

	end

	def message_body
		""
	end

	after_save do
		# Twilio code goes here
		number = self.number

		binding.pry
	end
end
