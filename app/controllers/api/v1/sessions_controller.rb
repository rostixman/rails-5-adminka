module Api
	module V1
		class SessionsController < ApiController
			include Devise::Controllers::SignInOut

			before_action :check_token, only: [:destroy]

			def create
				data = error = nil
				checked_params = check_params(params, require_params(:email))

				if checked_params.any?

					valid = false
					user = User.where(email: checked_params[:email].downcase).first
					valid = user.valid_password?(checked_params[:password]) unless user.nil?

					if valid
						data = user.generate_token(checked_params[:device_uid], checked_params[:device_type])
						sign_in user, store: false
					else
						error = create_error(401, 'Пароль либо E-mail не верны')
					end

				else
					error = create_error(400, 'Не все обязательные параметры отправлены',
					                     require_params(:email).to_s)
				end

				api_respond(data, error)
			end

			def destroy
				data = error = nil
				sign_out @token.user
				@token.destroy

				api_respond(data, error)
			end

			def require_params(type)
				result = []
				result = [:email, :password, :device_type] if type == :email
				result
			end

		end
	end
end