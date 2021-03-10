module Admin
	class UserRolesController < BaseController

		# ====================
		#     cancan init
		# ====================
		authorize_resource

		private
			# ====================
			#  model configuration
			# ====================
			def set_configuration
				@configuration = UserRoleModelConfiguration.new
			end
	end
end