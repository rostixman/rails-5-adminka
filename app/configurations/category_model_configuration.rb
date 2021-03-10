class CategoryModelConfiguration < BaseModelConfiguration

	def construct

		# ====================
		#  	      name
		# ====================
		@entity = Category
		@model_name = 'category'

		# ====================
		#  	   signatures
		# ====================
		@signatures = {
				# title and breadcrumbs
				create_element: 'Создание категории',
				edit_element: 'Редактирование категории',
				elements: 'Категории',

				# buttons
				add_element: 'Добавить категорию'
		}

		# ====================
		#  	   	 links
		# ====================
		@links = {
				elements: 'admin_categories_url',
				create_element: 'new_admin_category_url',
				edit_element: 'edit_admin_category_path',
				destroy_element: 'admin_category_path'
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
													 link: 'edit_admin_category_path(content[:row].id)',
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