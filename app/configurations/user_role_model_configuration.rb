class UserRoleModelConfiguration < BaseModelConfiguration

	def construct

		# ====================
		#  	      name
		# ====================
		@entity = UserRole
		@model_name = 'user_role'

		# ====================
		#  	   signatures
		# ====================
		@signatures = {
				# title and breadcrumbs
				create_element: 'Создание роли',
				edit_element: 'Редактирование роли',
				elements: 'Роли пользователей',

				# buttons
				add_element: 'Добавить роль'
		}

		# ====================
		#  	   	 links
		# ====================
		@links = {
				elements: 'admin_user_roles_url',
				create_element: 'new_admin_user_role_url',
				edit_element: 'edit_admin_user_role_path',
				destroy_element: 'admin_user_role_path'
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
									 caption: {text: 'Название (rus)', class: 'ru_name' },
									 block: {
											 name: 'cells/link',
											 content: {
													 value: 'content[:row].ru_name',
													 link: 'edit_admin_user_role_path(content[:row].id)',
													 route: true,
													 class: 'modal__edit-btn with-reload-page'
											 }
									 }
							 }, {
									 caption: {text: 'Название (eng)', class: 'name' },
									 block: {
											 name: 'cells/text',
											 content: {
													 value: 'content[:row].name',
											 }
									 }
							 }]

		# ====================
		#     field of form
		# ====================
		@form_fields = [{
								caption: {text: 'Название (rus)', class: 'ru_name' },
								block: {
										name: 'field_for_model/input',
										content: {
												value: 'ru_name'
										}
								},
								validates: {
										rules: { required: true },
										messages: {
												required: 'Поле «Название (rus)» обязательно для заполнения'
										}
								}
						}, {
								caption: {text: 'Название (eng)', class: 'name' },
								block: {
										name: 'field_for_model/input',
										content: {
												value: 'name',
										}
								},
								validates: {
										rules: { required: true },
										messages: {
												required: 'Поле «Название (eng)» обязательно для заполнения'
										}
								}
						}]
	end


end