class ApiController < ActionController::API
	# 200 - :ok
	# 204 - :no_content
	# 400 - :bad_request
	# 403 - :forbidden
	# 401 - :unauthorized
	# 404 - :not_found
	# 410 - :gone
	# 422 - :unprocessable_entity
	# 500 - :internal_server_error
	include ActionController::ImplicitRender
	
	def check_token
		data = error = nil
		
		if params[:token].nil?
			error = create_error(401, 'Данный метод требует авторизации')
		else
			@token = UserAuthToken.where({auth_token: params[:token]}).first
			error = create_error(401, 'Token не существует') if @token.nil?
		end
		
		api_respond(nil, error) unless error.nil?
	end
	
	def api_respond(data = nil, error = nil, status = 200, v = 'v1')
		
		@data = data
		@error = error
		@status =  !error
		
		@view = "#{params[:controller]}/#{params[:action]}"
		
		render template: "api/#{v}/respond.json", status: status
	end
	
	def check_params(params, require_params)
		result = []
		
		is_same = (require_params.map{|rp| rp = rp.to_s} - params.keys).empty?
		
		result = params if is_same
		
		result
	end
	
	def create_error(code, message, desc = '')
		error = ApiError.new
		error.code = code
		error.message = message
		error.desc = desc
		
		error
	end
end