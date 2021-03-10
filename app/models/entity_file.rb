class EntityFile < ActiveRecord::Base
	# includes
	include BaseModel

	# relations
	belongs_to :user

	# plugins
	mount_uploader :file, EntityFileUploader

	# methods
	def table_row_color
	end
end
