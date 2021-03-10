module Admin
    class NamespaceController < ApplicationController

		# ====================
		#  	 before actions
		# ====================
	    before_action :authenticate_user!

		# ====================
		#  	 default layout
		# ====================
	    layout 'admin/default/application'

		# ====================
		#  	 base admin url
		# ====================
		def base
			flash[:message] = {title: 'Поздравляю', type: 'success', text: 'Вы успешно авторизовались', icon: 'fa fa-bell-o'}
			redirect_to admin_dashboard_path
		end

		# ====================
		#  	 reload select
		# ====================
		def reload_select_data
			if params[:select]
				entity, value = params[:select][:entity], params[:select][:value]
				data = ''

				configuration = eval("#{entity}ModelConfiguration.new")
				configuration.form_fields.each do |field|
					if field[:block][:content][:value] == value
						data = eval(field[:block][:content][:options])
					end
				end

				render json: data
			end
		end

		# ====================
		#  	 cancan access
		# ====================
		rescue_from CanCan::AccessDenied do |exception|
		    redirect_to admin_root_url, :notice => 'У вас недостаточно прав, чтобы просмотреть данный раздел' #exception.message
		end
    end
end
