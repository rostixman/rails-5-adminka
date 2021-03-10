module Api
	module V1
		class PasswordsController < ApiController
			include Devise::Controllers::SignInOut

			before_action :check_token, only: []

			def recovery
				data = error = nil
				checked_params = check_params(params, require_params(:recovery))

				if checked_params.any?

					user = User.where(email: checked_params[:email].downcase).first

					if user.nil?
						error = create_error(401, 'Пользователь с таким E-mail не зарегистрирован')
					else
						password = SecureRandom.hex(8)
						user.password = password
						user.save

						# TODO отправляем на почту пользователю новый пароль
						# @send = UsersMailer.after_social_registration(checked_params[:email], password).deliver_later
					end

				else
					error = create_error(400, 'Не все обязательные параметры отправлены',
					                     require_params(:email).to_s)
				end

				api_respond(data, error)
			end

				def require_params(type)
					result = []
					result = [:email] if type == :recovery
					result
				end

		end
	end
end