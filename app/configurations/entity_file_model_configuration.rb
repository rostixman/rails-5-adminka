class EntityFileModelConfiguration < BaseModelConfiguration

	def construct

		# ====================
		#  	      name
		# ====================
		@entity = EntityFile
		@model_name = 'entity_file'

		# ====================
		#  	   signatures
		# ====================
		@signatures = {
				# title and breadcrumbs
				create_element: 'Создание файла',
				edit_element: 'Редактирование файла',
				elements: 'Файлы',

				# buttons
				add_element: 'Добавить файл'
		}

		# ====================
		#  	   	 links
		# ====================
		@links = {
				elements: 'admin_entity_files_url',
				create_element: 'new_admin_entity_file_url',
				edit_element: 'edit_admin_entity_file_path',
				destroy_element: 'admin_entity_file_path'
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
									 caption: {text: 'Сущность', class: 'entity' },
									 block: {
											 name: 'cells/text',
											 content: {
													 value: 'content[:row].entity'
											 }
									 }
							 },{
									 caption: {text: 'ID сущности', class: 'entity_id' },
									 block: {
											 name: 'cells/text',
											 content: {
													 value: 'content[:row].entity_id'
											 }
									 }
							 },{
									 caption: {text: 'Поле', class: 'name' },
									 block: {
											 name: 'cells/text',
											 content: {
													 value: 'content[:row].name'
											 }
									 }
							 },{
									 caption: {text: 'Заголовок', class: 'title' },
									 block: {
											 name: 'cells/text',
											 content: {
													 value: 'content[:row].title'
											 }
									 }
							 },{
									 caption: {text: 'Тип контента', class: 'content_type' },
									 block: {
											 name: 'cells/text',
											 content: {
													 value: 'content[:row].content_type'
											 }
									 }
							 },{
									 caption: {text: 'Название файла', class: 'original_filename' },
									 block: {
											 name: 'cells/text',
											 content: {
													 value: 'content[:row].original_filename'
											 }
									 }
							 },{
									 caption: {text: 'Размера', class: 'size' },
									 block: {
											 name: 'cells/text',
											 content: {
													 value: 'content[:row].size'
											 }
									 }
							 },{
									 caption: {text: 'Вес', class: 'weight' },
									 block: {
											 name: 'cells/text',
											 content: {
													 value: 'content[:row].weight'
											 }
									 }
							 },{
									 caption: {text: 'Главное?', class: 'main' },
									 block: {
											 name: 'cells/text',
											 content: {
													 value: '(content[:row].main==1 ? "Да" : "")'
											 }
									 }
							 },{
									 caption: {text: 'Язык', class: 'locale' },
									 block: {
											 name: 'cells/text',
											 content: {
													 value: 'content[:row].locale'
											 }
									 }
							 },{
									 caption: {text: 'Описание', class: 'desc' },
									 block: {
											 name: 'cells/textarea',
											 content: {
													 value: 'content[:row].desc'
											 }
									 }
							 },{
									 caption: {text: 'Пользователь', class: 'user_id' },
									 block: {
											 name: 'cells/text',
											 content: {
													 value: 'content[:row].user_id'
											 }
									 }
							 }]

		# ====================
		#     field of form
		# ====================
		@form_fields = [{
								caption: {text: 'Заголовок', class: 'title' },
								block: {
										name: 'field_for_model/input',
										content: {
												value: 'title'
										}
								},
								validates: {
										rules: { required: true },
										messages: {
												required: 'Поле «Заголовок» обязательно для заполнения'
										}
								}
						},{
								caption: {text: 'Вес', class: 'weight' },
								block: {
										name: 'field_for_model/input',
										content: {
												value: 'weight'
										}
								},
								validates: {
										rules: { required: true },
										messages: {
												required: 'Поле «Заголовок» обязательно для заполнения'
										}
								}
						}, {
								caption: {text: 'Описание', class: 'desc' },
								block: {
										name: 'field_for_model/textarea',
										view: 'summernote',
										content: {
												value: 'desc'
										}
								},
								validates: {
										rules: { },
										messages: { }
								}
						}, {
								caption: {text: 'Главное изображение?', class: 'desc' },
								block: {
										name: 'field_for_model/logical',
										content: {
												value: 'main'
										}
								},
								validates: {
										rules: { },
										messages: { }
								}
						}]
	end

end