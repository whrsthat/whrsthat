require 'twilio-ruby'

class EventUser < ActiveRecord::Base
	has_many :users
	belongs_to :event
	validates :number, uniqueness: { scope: :event_id, message: 'One number per event invite' }

	def event
		Event.find(self.event_id)
	end

	def user
		User.find_by(:phone => self.number)
	end

	def event_author 
		User.find(event.user_id)
	end

	def set_default_values
		self.accepted ||= false
	end

	def event_author
		User.find(event.user_id)
	end

	def twilio 
		account_sid = ENV['TWILIO_SID']
		auth_token = ENV['TWILIO_AUTH_TOKEN']

		@twilio ||= Twilio::REST::Client.new account_sid, auth_token
	end

	def message_body
		base = "#{event_author.fname} #{event_author.lname_initial} has invited you to the event #{event.title}, which will be at #{event.event_address} #{event.date} at #{event.time}"
		if user
			base += " Text Y to RSVP or N to decline"
		else
			base += " Click #{ENV['EXTERNAL_URL']}/rsvp/#{self.id} to rsvp"
		end
	end

	after_save do
		if self.accepted == nil
			# Twilio code goes here
			number = self.number

			twilio.messages.create(
				from: ENV['TWILIO_FROM_NUMBER'],
				to: self.number,
				body: message_body
			)

		end

	end
end