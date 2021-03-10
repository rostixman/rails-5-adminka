class UserStatus < ActiveRecord::Base
	# includes
	include BaseModel

	# relations
	has_many :users, class_name: 'User', foreign_key: :user_status_id, dependent: :nullify

	# methods
	def table_row_color
	end

	def relation_cant_be_blank
		[:users]
	end

end
