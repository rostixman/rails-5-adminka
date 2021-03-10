module Site
	class ErrorsController < NamespaceController

		include CustomErrors

		skip_before_action :authenticate_user!

		def show
			# Here, the `@exception` variable contains the original raised error
			render "errors/#{@rescue_response}", status: @status_code
		end
	end
end

