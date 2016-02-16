class User < ActiveRecord::Base
	has_many :events
	has_many :invitees, through: :events
	has_secure_password
	validates_uniqueness_of :email
	validates_uniqueness_of	 :phone

	def name 
		"#{self.fname} #{self.lname_initial}"
	end
end
