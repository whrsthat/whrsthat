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

	def set_default_values
		self.accepted ||= false
	end

	after_save do
		# Twilio code goes here
		number = self.number
	end
end
