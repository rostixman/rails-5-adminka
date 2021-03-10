module Admin
	class CategoriesController < BaseController

		# ====================
		#     cancan init
		# ====================
		authorize_resource

		private
			# ====================
			#  model configuration
			# ====================
			def set_configuration
				@configuration = CategoryModelConfiguration.new
			end
	end
end