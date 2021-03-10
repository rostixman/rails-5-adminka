module Api
	module V1
		class UsersController < ApiController

			before_action :check_token, only: [:list]

			def create
				data = error = nil
				checked_simple_params = check_params(params, require_params(:create_simple))
				checked_social_params = check_params(params, require_params(:create_social))

				# email auth
				if checked_simple_params.any?
					checked_params = checked_simple_params

					if  checked_params[:email].nil?
						error = create_error(400, 'Не все обязательные параметры отправлены',
						                     'Обязательно должен быть email')
					else
						query_params = {}
						query_params[:email] = checked_params[:email].downcase
						query_params[:name] = checked_params[:email].downcase.slice(0..(checked_params[:email].index('@')-1))
						query_params[:password] = checked_params[:password]
						query_params[:user_status_id] = UserStatus.find_by_name('Активен').id
						query_params[:user_role_id] = UserRole.find_by_name('user').id
						query_params[:rating] = 0
						query_params[:wins] = 0
						query_params[:louses] = 0
						query_params[:draws] = 0
						query_params[:coins] = 0

						user = User.new(query_params)

						if user.save
							data = user.generate_token(checked_params[:device], checked_params[:device_type])
							sign_in user, store: false
						else
							error = create_error(400, 'Не получилось зарегистрироваться', user.errors.full_messages.first)
						end

					end

				# social auth
				elsif checked_social_params.any?
					checked_params = checked_social_params

					# login VK
					if checked_params[:social_type] == 'vk'

						client_id = '5755635'
						client_secret = '0YTAiJeRetS92sMyHmCL'

						c = Curl::Easy.perform("https://oauth.vk.com/access_token?client_id=#{client_id}&client_secret=#{client_secret}&v=5.34&grant_type=client_credentials")
						c = Curl::Easy.perform("https://api.vk.com/method/secure.checkToken?token=#{checked_params[:social_token]}&client_secret=#{client_secret}&access_token=#{JSON.parse(c.body_str)['access_token']}")
						result = JSON.parse(c.body_str)

						if (result.include? 'response') &&
								(checked_params[:social_id].to_i == result['response']['user_id'].to_i)

							vk = VkontakteApi::Client.new(checked_params[:social_token])
							vk_user = vk.users.get(uid: checked_params[:social_id],
							                       fields: [:email, :contacts, :first_name, :last_name, :photo_max]).try(:first)

							temp_email = "#{vk_user.uid}@mytumen.ru"
							user ||= User.where('lower(email) = ?', temp_email).first
							user ||= User.where(:vk_id => checked_params[:social_id]).first
							is_save = false

							if user.nil?

								query_params = {}
								query_params[:email] = temp_email
								query_params[:name] = "#{vk_user.first_name} #{vk_user.last_name}"
								query_params[:password] = SecureRandom.hex(8)
								query_params[:vk_id] = checked_params[:social_id]
								query_params[:vk_email] = vk_user.email
								query_params[:vk_phone] = vk_user.mobile_phone
								query_params[:vk_name] = "#{vk_user.first_name} #{vk_user.last_name}"
								query_params[:vk_token] = checked_params[:social_token]
								query_params[:user_status_id] = UserStatus.find_by_name('Активен').id
								query_params[:user_role_id] = UserRole.find_by_name('user').id
								query_params[:rating] = 0
								query_params[:wins] = 0
								query_params[:louses] = 0
								query_params[:draws] = 0
								query_params[:coins] = 0

								user = User.new(query_params)
								is_save = user.save

								if is_save

									data = user.generate_token(checked_params[:device_uid], checked_params[:device_type])
									sign_in user, store: false
								else
									error = create_error(400, 'Не получилось зарегистрироваться через Вконтакте', user.errors.full_messages.first)
								end
							else
								is_save = true
								user.vk_id = checked_params[:social_id]
								user.vk_token = checked_params[:social_token]

								data = user.generate_token(checked_params[:device_uid], checked_params[:device_type])
								sign_in user, store:false
							end

							if is_save && !vk_user.photo_max.nil?
								EntityFile.where(entity: 'User', entity_id: user.id, name: 'avatar').destroy_all
								avatar = EntityFile.new({entity: 'User', entity_id: user.id, name: 'avatar', main: 1, locale: 'ru', weight: 0})
								avatar.remote_file_url = vk_user.photo_max
								avatar.save
							end

						elsif result.include? 'error'
							error = create_error(400, 'Не получилось зарегистрироваться',
							                     result['error']['error_code'].to_s + ' ' + result['error']['error_msg'].to_s)
						elsif id.to_i != result['response']['user_id'].to_i
							error = create_error(400, 'Не получилось зарегистрироваться',
							                     'VK_USER_ID != TOKEN_USER_ID')
						end

					# login FB
					elsif checked_params[:social_type] == 'fb'

						graph = Koala::Facebook::API.new(checked_params[:social_token])
						fb_user = graph.get_object('me?fields=id,name')
						picture = graph.get_object('me?fields=picture')

						if (!picture.nil?) &&
								(picture.include?('picture')) &&
								(picture['picture'].include?('data')) &&
								(picture['picture']['data'].include?('url'))
							picture = picture['picture']['data']['url']
						else
							picture = nil
						end

						if (fb_user.include? 'id') && (fb_user['id'] == checked_params[:social_id])

							is_save = false
							temp_email = "#{fb_user['id']}@mytumen.ru"
							user = User.where('lower(email) = ?', temp_email).try(:first)
							user ||= User.where(:fb_id => checked_params[:social_id]).try(:first)

							if user.nil?

								query_params = {}
								query_params[:email] = temp_email
								query_params[:name] = fb_user['name']
								query_params[:password] = SecureRandom.hex(8)
								query_params[:fb_id] = checked_params[:social_id]
								query_params[:fb_token] = checked_params[:social_token]
								query_params[:user_status_id] = UserStatus.find_by_name('Активен').id
								query_params[:user_role_id] = UserRole.find_by_name('user').id
								query_params[:rating] = 0
								query_params[:wins] = 0
								query_params[:louses] = 0
								query_params[:draws] = 0
								query_params[:coins] = 0

								user = User.new(query_params)
								is_save = user.save

								if is_save
									data = user.generate_token(checked_params[:device_uid], checked_params[:device_type])

									sign_in user, store: false
								else
									error = create_error(400, 'Не получилось зарегистрироваться через Facebook', user.errors.full_messages.first)
								end
							else
								is_save = true
								user.fb_id = checked_params[:social_id]
								user.fb_token = checked_params[:social_token]
								data = user.generate_token(checked_params[:device_uid], checked_params[:device_type])

								sign_in user, store: false
							end

							if is_save && !picture.nil?
								EntityFile.where(entity: 'User', entity_id: user.id, name: 'avatar').destroy_all
								avatar = EntityFile.new({entity: 'User', entity_id: user.id, name: 'avatar', main: 1, locale: 'ru', weight: 0})
								avatar.remote_file_url = picture
								avatar.save
							end
						else
							error = create_error(400, 'Не получилось зарегистрироваться через Facebook', 'social_token не пренадлежит вашему social_id')
						end
					end
				else
					error = create_error(400, 'Не все обязательные параметры указаны')
				end

				api_respond(data, error)
			end

			def list
				data = error = nil

				params[:page] = 1 if params[:page].nil?
				params[:per_page] = 10 if params[:per_page].nil?

				query_params = {}
				query_params[:id] = params[:user_id] if params[:user_id]

				# if params[:only_friends]
				# 	query_params[:id] = @token.user.friends.map{|datum| [datum.friend_id]}
				# end

				sql_string = (params[:query] ? filter_name(params[:query]) : '')

				data = User.where(query_params)
						       .where(sql_string)
						       .order(count_answers: :desc)
						       .paginate(page: params[:page],
						                 per_page: params[:per_page])



				api_respond(data, error)
			end

			def show
				data = error = nil

				checked_params = check_params(params, require_params(:show))

				if checked_params.any?
					token = UserAuthToken.where({auth_token: checked_params[:token]}).first
					data = token.user
				else
					error = create_error(401, 'Не все обязательные параметры указаны')
				end

				api_respond(data, error)
			end

			# TODO переделать
			def allow_notice
				@token.notify = 1
				@token.device_token = params[:device_token]
				@token.save
				@message = 'Вы успешно подписались на пуши'
				render template: 'api/v1/notice/allow.json', status: :ok
			end

			# TODO переделать
			def disallow_notice
				@token.notify = 0
				@token.device_token = ''
				@token.save
				@message = 'Вы успешно отписались от пушей'
				render template: 'api/v1/notice/disallow.json', status: :ok
			end


				def require_params(type)
					result = []
					result = [:email, :password, :device_uid, :device_type] if type == :create_simple
					result = [:social_id, :social_type, :social_token, :device_uid, :device_type] if type == :create_social
					result = [:token] if type == :show
					result
				end

				def filter_name(param_search)
					splitted_string = param_search.mb_chars.downcase.to_s.gsub(/\s+/m, ' ').split(' ')
					splitted_values = splitted_string.map {|val| "%#{val}%" }

					splitted_values.each do |word|
						word = word.to_s.gsub!(/\./,",")
					end

					filter_query_string = 'lower(name) LIKE ALL (array[?]) OR lower(email) LIKE ALL (array[?]) OR lower(vk_name) LIKE ALL (array[?]) OR lower(fb_name) LIKE ALL (array[?])', splitted_values, splitted_values, splitted_values, splitted_values

					filter_query_string
				end
		end
	end
end