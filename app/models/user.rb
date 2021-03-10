class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		   :recoverable,              :rememberable,
		   :trackable,                :validatable


	# includes
	include BaseModel

	# relations
	belongs_to :role,          class_name: 'UserRole',      foreign_key: :user_role_id
	belongs_to :status,        class_name: 'UserStatus',    foreign_key: :user_status_id

	has_many :tokens,          class_name: 'UserAuthToken', dependent: :delete_all

	# many to many
	has_many :users_categories, class_name: 'UsersCategory',  dependent: :delete_all
	has_many :categories,       class_name: 'Category',      through: :users_categories

	# methods
	def is_active?
		self.user_status_id == 1
	end

	def table_row_color
		'danger' if self.user_status_id == 2
		'warning' if self.user_status_id == 3
	end

	def full_name
		name = ''
		name += self.email if (self.first_name == '') && (self.second_name == '') && (self.last_name == '')
		name += " #{self.first_name}" if self.first_name
		name += " #{self.second_name}" if self.second_name
		name += " #{self.last_name}" if self.last_name
		name += " (#{self.email})" if (self.first_name != '') || (self.second_name != '') || (self.last_name != '')
		name
	end

	def role?(role)
		self.role.name == role.to_s
	end
end
