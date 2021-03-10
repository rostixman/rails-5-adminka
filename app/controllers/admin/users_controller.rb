module Admin
	class UsersController < BaseController
		# ====================
		#     cancan init
		# ====================
		authorize_resource

		# ====================
		#      CREATE +/-
		# ====================
		#    create success
		# ====================
		def create_success
			super

			# puts @object
		end

		private
			# ====================
			#  model configuration
			# ====================
			def set_configuration
				@configuration = UserModelConfiguration.new
			end

			# ====================
			#     permit params
			# ====================
			def permit_params
				out_params = ''
				form_fields = @configuration.form_fields
				if ( (!params[:user][:password].nil?) && (params[:user][:password].length > 0) ) ||
					  (params[:action] == 'create')
					form_fields.each_with_index do |attr, index|
						out_params += ":#{attr[:block][:content][:value]}#{',' if (form_fields.count-1) != index}"
					end
				else
					form_fields.each_with_index do |attr, index|
						if attr[:block][:content][:value] != 'password'
							out_params += ":#{attr[:block][:content][:value]}#{',' if (form_fields.count-1) != index}"
						end
					end
				end
				eval("params[:#{@configuration.model_name}].permit(#{out_params})")
			end
	end
end