class BaseSetting

	attr_reader :menu
	attr_reader :logo
	attr_reader :copyright

	def initialize
		@menu = {}
		@logo = ''
		@copyright = ''
		construct
	end

	public
	def construct
		# should be override
	end

end