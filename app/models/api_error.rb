class ApiError

	attr_accessor :code
	attr_accessor :message
	attr_accessor :desc

	def initialize
		@code = 200
		@message = ''
		@desc = ''
		construct
	end

	public
	def construct
		# should be override
	end

end
