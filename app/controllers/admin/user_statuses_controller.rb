module Admin
	class UserStatusesController < BaseController

		# ====================
		#     cancan init
		# ====================
		authorize_resource

		private
			# ====================
			#  model configuration
			# ====================
			def set_configuration
				@configuration = UserStatusModelConfiguration.new
			end
	end
end