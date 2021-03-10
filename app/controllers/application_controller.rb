class ApplicationController < ActionController::Base

	# ====================
	#       protect
	# ====================
	protect_from_forgery with: :exception

	# ====================
	#    before actions
	# ====================
	skip_before_action :verify_authenticity_token, if: :json_request?

	# ====================
	#  check json request
	# ====================
	def json_request?
		request.format.json?
	end
end
