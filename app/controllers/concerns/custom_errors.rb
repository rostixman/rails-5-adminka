module CustomErrors

	# ====================
	#    	 extend
	# ====================
	extend ActiveSupport::Concern

	# ====================
	#       included
	# ====================
	def self.included(base)

		base.before_action :fetch_exception, only: %w(show)
		base.before_action :append_view_paths

	end

	protected
		def fetch_exception
			@exception = request.env['action_dispatch.exception']
			@status_code = ActionDispatch::ExceptionWrapper.new(request.env, @exception).status_code
			@rescue_response = ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]
		end

	private
		def append_view_paths
			append_view_path Gaffe.root.join('app/views')
		end
end
