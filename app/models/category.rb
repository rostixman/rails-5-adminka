class Category < ActiveRecord::Base

	# includes
	include BaseModel

	# relations

	# methods
	def table_row_color
	end

	def relation_cant_be_blank
		[]
	end
end
