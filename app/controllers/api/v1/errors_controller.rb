module Api
	module V1
		class ErrorsController < ApiController

			include CustomErrors

			skip_before_action :authenticate_user!

			def show
				error = create_error(404, 'Not Found')
				api_respond(nil, error)
			end
		end
	end
end