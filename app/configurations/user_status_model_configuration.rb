class UserStatusModelConfiguration < BaseModelConfiguration

	def construct

		# ====================
		#  	      name
		# ====================
		@entity = UserStatus
		@model_name = 'user_status'

		# ====================
		#  	   signatures
		# ====================
		@signatures = {
				# title and breadcrumbs
				create_element: 'Создание статуса пользователя',
				edit_element: 'Редактирование статуса пользователя',
				elements: 'Статусы пользователей',

				# buttons
				add_element: 'Добавить статус пользователя'
		}

		# ====================
		#  	   	 links
		# ====================
		@links = {
				elements: 'admin_user_statuses_url',
				create_element: 'new_admin_user_status_url',
				edit_element: 'edit_admin_user_status_path',
				destroy_element: 'admin_user_status_path'
		}

		# ====================
		#  properties of table
		# ====================
		@table_properties = [{
									 caption: {text: '#', class: 'id' },
									 block: {
											 name: 'cells/text',
											 content: {
													 value: 'content[:row].id'
											 }
									 }
							 },{
									 caption: {text: 'Название', class: 'name' },
									 block: {
											 name: 'cells/link',
											 content: {
													 value: 'content[:row].name',
													 link: 'edit_admin_user_status_path(content[:row].id)',
													 route: true,
													 class: 'modal__edit-btn with-reload-page'
											 }
									 }
							 }]

		# ====================
		#     field of form
		# ====================
		@form_fields = [{
								caption: {text: 'Название', class: 'name' },
								block: {
										name: 'field_for_model/input',
										content: {
												value: 'name'
										}
								},
								validates: {
										rules: { required: true },
										messages: {
												required: 'Поле «Название» обязательно для заполнения'
										}
								}
						}]
	end


end