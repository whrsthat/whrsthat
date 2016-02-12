require 'fileutils'

class EventPhoto < ActiveRecord::Base

	belongs_to :event

	attr_accessor :file

	validates :format, inclusion: ['jpg']

	before_validation do
		if @file.present?
			self.format = Rack::Mime::MIME_TYPES.invert[@file.content_type].gsub('.', '')
		end	
	end

	after_save do
		#defining location and setting up the structure of the path
		path = Rails.root.join('public', 'photos', "#{id}.#{format}")
		image = MiniMagick::Image.open(@file.path)
		image.resize "300x300"
		image.write path
		# FileUtils.mv(@file.path, path)
	end
end
