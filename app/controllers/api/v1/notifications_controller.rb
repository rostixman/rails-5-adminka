module Api
	module V2
		class NotificationsController < ApiController

			before_action :check_token, only: [:create, :destroy]

			def create
				data = error = nil

				@token.notify = 1
				@token.device_token = params[:device_token]
				is_save = @token.save

				error = create_error(400, 'Не получилось подписаться на пуши') unless is_save

				api_respond(data, error)
			end

			def destroy
				data = error = nil

				@token.notify = 0
				@token.device_token = ''
				is_save = @token.save

				error = create_error(400, 'Не получилось отписаться от пушей') unless is_save

				api_respond(data, error)
			end
		end
	end
end