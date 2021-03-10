module Admin
	class EntityFilesController < BaseController

		# ====================
		#        UPLOAD
		# ====================
		def upload
			file, entity, entity_id, name, locale =  params[:file], params[:entity], params[:entity_id], params[:name], params[:locale]

			default_template = params[:default_template]
			default_template ||= '_upload'

			@entity_file = EntityFile.create({entity: entity,
										  	 entity_id: entity_id,
											 name: name,
											 title: file.original_filename,
											 file: file,
											 main: 0,
											 weight: 0,
											 desc: '',
											 locale: locale,
											 content_type: file.content_type,
											 original_filename: file.original_filename,
											 user: current_user,
											 size: file.size})

			respond_to do |format|
				format.html {render default_template, layout: false }
				format.json {render json: {entity_file: @entity_file} }
			end
		end

		# ====================
		#        REMOVE
		# ====================
		def remove
			EntityFile.destroy_all(id: params[:id])

			respond_to do |format|
				format.json {render :json => {result: 'success'}}
			end

		end

		private
			# ====================
			#  model configuration
			# ====================
			def set_configuration
				@configuration = EntityFileModelConfiguration.new
			end
	end
end