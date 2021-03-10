module Admin
	module EntityFiles

		# ====================
		#    	 extend
		# ====================
		extend ActiveSupport::Concern

		# ====================
		#       included
		# ====================
		def self.included(base)
			# before
			base.before_action  :clear_images, 		only: [:new]

			# after
			base.after_action   :upload_images, 	only: [:create]
			base.after_action   :destroy_images, 	only: [:destroy]
		end

		# ====================
		#     clear images
		# ====================
		def clear_images
			files = EntityFile.where(entity: controller_name.classify, entity_id: 0, user: current_user )
			files.try(:destroy_all)
		end

		# ====================
		#    upload images
		# ====================
		def upload_images
			object = @object

			files = params[:files]
			unless files.blank?
				files = EntityFile.where(id: files[:id])

				# if active record error destroy all images
				if object.errors.count > 0
					files.try(:destroy_all)
				else
					files.each do |file|
						if file.entity_id == 0
							file.entity_id = object.id
							file.save
						end
					end
				end
			end
		end

		# ====================
		#    destroy images
		# ====================
		def destroy_images
			object = @object

			if params[:agree]
				files = EntityFile.where(entity: controller_name.classify, entity_id: object.id )
				files.try(:destroy_all)
			end
		end
	end
end
