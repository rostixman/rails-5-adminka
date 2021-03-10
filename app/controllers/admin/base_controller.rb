module Admin
    class BaseController < NamespaceController

		# ====================
		#       includes
		# ====================
		include Admin::EntityFiles

		# ====================
		#    before actions
		# ====================
		before_action :set_configuration
		before_action :set_model_object, 	only: [:edit, :update,  :destroy]
		before_action :set_template, 		only: [:edit, :new, 	:destroy]

		# ====================
		#        INDEX
		# ====================
		def index
			before_index
			after_index
		end

		# ====================
		#         NEW
		# ====================
		def new
			before_new
			after_new
		end

		# ====================
		#         EDIT
		# ====================
		def edit
			before_edit
			after_edit
		end

		# ====================
		#        CREATE
		# ====================
		def create
			before_create
			create_middle
			after_create
		end

		# ====================
		#       UPDATE
		# ====================
		def update
			before_update
			update_middle
			after_update
		end

		# ====================
		#       DELETE
		# ====================
		def destroy
			before_destroy
			destroy_middle
			after_destroy
		end


		public
			# ====================
			#  model configuration
			# ====================
			def set_configuration
				@configuration = BaseModelConfiguration.new
			end

			# ====================
			#  	 permit params
			# ====================
			def permit_params
				eval(@configuration.get_params)
			end

			# ====================
			#  	set model object
			# ====================
			def set_model_object
				@object = @configuration.entity.find(params[:id])
			end

			# ====================
			#  	  set template
			# ====================
			def set_template
				@template_view = 'default'
				@template_view = 'modal' if params[:modal]
			end


			# ====================
			#        AFTER
			# ====================
			#     after index
			# ====================
			def after_index
			end

			# ====================
			#      after edit
			# ====================
			def after_edit
				respond_to do |format|
					format.html { render layout: "admin/#{@template_view}/application" }
				end
			end

			# ====================
			#      after new
			# ====================
			def after_new
				respond_to do |format|
					format.html {render layout: "admin/#{@template_view}/application"}
				end
			end

			# ====================
			#     after create
			# ====================
			def after_create
				respond_to do |format|
					if @respond
						format.html { redirect_to @redirect}
						format.json { head :no_content }
					else
						format.html { render action: 'new' }
						format.json { head :no_content }
					end
				end
			end

			# ====================
			#     after update
			# ====================
			def after_update
				respond_to do |format|
					if @respond
						format.html { redirect_to @redirect }
						format.json { head :no_content }
					else
						format.html { render action: 'edit' }
						format.json { render json: @object.errors, status: :unprocessable_entity }
					end
				end
			end

			# ====================
			#     after destroy
			# ====================
			def after_destroy
				if params[:agree]

					respond_to do |format|
						format.html { redirect_to @redirect }
						format.json { head :no_content }
					end
				else
					respond_to do |format|
						format.html { render layout: "admin/#{@template_view}/application" }
					end
				end
			end

			# ====================
			#        BEFORE
			# ====================
			#     before index
			# ====================
			def before_index
				@objects = @configuration.entity.all
			end

			# ====================
			#      before edit
			# ====================
			def before_edit
			end

			# ====================
			#      before new
			# ====================
			def before_new
				@object = @configuration.entity.new
			end

			# ====================
			#     before create
			# ====================
			def before_create
				@object = @configuration.entity.new(permit_params)
			end

			# ====================
			#     after update
			# ====================
			def before_update
			end

			# ====================
			#     after destroy
			# ====================
			def before_destroy
			end


			# ====================
			#      CREATE +/-
			# ====================
			#    create success
			# ====================
			def create_success
				flash[:message] = create_success_message

				@respond = true
				@redirect = create_success_redirect
			end
			# ====================
			#    create fail
			# ====================
			def create_fail
				@respond = false
			end
			# ====================
			#   success redirect
			# ====================
			def create_success_redirect
				eval(@configuration.links[:elements])
			end
			# ====================
			#   success message
			# ====================
			def create_success_message
				{:title => 'Информация', :type => 'success', :text => 'Запись успешно создана', :icon => 'fa fa-check-circle'}
			end
			# ====================
			#    middle create
			# ====================
			def create_middle
				if @object.save
					create_success
				else
					create_fail
				end
			end


			# ====================
			#      UPDATE +/-
			# ====================
			#    update success
			# ====================
			def update_success
				@respond = true
				flash[:message] = create_update_message
				@redirect = update_success_redirect
			end
			# ====================
			#    update fail
			# ====================
			def update_fail
				@respond = false
			end
			# ====================
			#   success redirect
			# ====================
			def update_success_redirect
				eval(@configuration.links[:elements])
			end
			# ====================
			#   success message
			# ====================
			def create_update_message
				{title: 'Информация', type: 'success', text: 'Запись успешно обновлена', icon: 'fa fa-check-circle'}
			end
			# ====================
			#    middle update
			# ====================
			def update_middle
				if @object.update(permit_params)
					update_success
				else
					update_fail
				end
			end


			# ====================
			#      DESTROY +/-
			# ====================
			#    destroy_success
			# ====================
			def destroy_success
				@object.destroy
				@redirect = destroy_success_redirect
			end
			# ====================
			#   success redirect
			# ====================
			def destroy_success_redirect
				eval(@configuration.links[:elements])
			end
			# ====================
			#    middle destroy
			# ====================
			def destroy_middle
				if params[:agree]
					destroy_success
				end
			end
    end
end
