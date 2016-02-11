class User < ActiveRecord::Base
	has_many :events
	has_many :invitees, through: :events
	has_secure_password
end
