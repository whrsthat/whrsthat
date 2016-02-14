class EventUser < ActiveRecord::Base
	has_many :users
	belongs_to :event
	def event
		Event.find(self.event_id)
	end

	def user
		User.find(self.user_id)
	end
end
