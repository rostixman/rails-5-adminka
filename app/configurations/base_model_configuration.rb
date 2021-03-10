class BaseModelConfiguration

	# ====================
	#  	  attributions
	# ====================
	attr_reader :table_properties
	attr_reader :signatures
	attr_reader :links
	attr_reader :form_fields
	attr_reader :entity
	attr_reader :model_name
	attr_reader :edited_tabs

	# ====================
	#  	  	  init
	# ====================
	def initialize
		@table_properties = []
		@signatures = []
		@links = []
		@form_fields = []
		@entity = nil
		@model_name = nil
		@edited_tabs = nil
		construct
	end

	public
		# ====================
		#  	   construct
		# ====================
		def construct
			# should be overriden
		end

		# ====================
		#  	     params
		# ====================
		def get_params
			out_params = ''
			self.form_fields.each_with_index do |attr, index|
				entity_file_cond = attr[:block][:name] != 'field_for_model/file'

				sep_cond = (index != 0) && entity_file_cond; sep = ''
				if sep_cond; sep = ', ' end

				out_params += "#{sep}:#{attr[:block][:content][:value]}" if entity_file_cond
			end
			"params.require(:#{@model_name}).permit(#{out_params})"
		end


end