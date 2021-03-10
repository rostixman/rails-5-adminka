class UserModelConfiguration < BaseModelConfiguration

	def construct

		# ====================
		#  	      name
		# ====================
		@entity = User
		@model_name = 'user'

		# ====================
		#  	   signatures
		# ====================
		@signatures = {
				# title and breadcrumbs
				create_element: 'Создание пользователя',
				edit_element: 'Редактирование пользователя',
				elements: 'Пользователи',

				# buttons
				add_element: 'Добавить пользователя'
		}

		# ====================
		#  	   	 links
		# ====================
		@links = {
				elements: 'admin_users_url',
				create_element: 'new_admin_user_url',
				edit_element: 'edit_admin_user_path',
				destroy_element: 'admin_user_path'
		}

		# ====================
		#  properties of table
		# ====================
		@table_properties = [{
									 caption: {text: '#', class: 'id' },
									 block: {
											 name: 'cells/text',
											 content: {
													 value: 'content[:row].id',
											 }
									 }
							 },{
									 caption: {text: 'ФИО', class: 'name' },
									 block: {
											 name: 'cells/link',
											 content: {
													 value: 'content[:row].full_name',
													 link: 'edit_admin_user_path(content[:row].id)',
													 route: true,
													 class: 'modal__edit-btn with-reload-page'
											 }
									 }
							 }, {
									 caption: {text: 'Дата создания', class: 'created_at' },
									 block: {
											 name: 'cells/text',
											 view: 'date',
											 content: {
													 value: 'content[:row].created_at'
											 }
									 }
							 }]

		# ====================
		#     field of form
		# ====================
		@form_fields = [{
								caption: {text: 'E-mail', class: 'email' },
								block: {
										name: 'field_for_model/input',
										view: 'email',
										content: {
												value: 'email',
												tooltip_text: 'Пример: example@gmail.com'
										}
								},
								validates: {
										rules: {
												required: true,
												regex: "^[-a-z0-9!#$%&'*+/=?^_`{|}~]+(?:\\.[-a-z0-9!#$%&'*+/=?^_`{|}~]+)*@(?:[a-z0-9]([-a-z0-9]{0,61}[a-z0-9])?[.]+)+(?:aero|arpa|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|tel|travel|[a-z][a-z])$".html_safe
										},
										messages: {
												required: 'Поле «E-mail» обязательно для заполнения',
												regex: 'Некорректно указан E-mail'
										}
								}
						}, {
								caption: {text: 'Пароль', class: 'password' },
								block: {
										name: 'field_for_model/input',
										view: 'password',
										content: {
												value: 'password',
												tooltip_text: 'Пароль должен быть не менее 8 символов',
												help_text: 'Если не хотите менять пароль, оставьте поле <u>пустым</u>',
										}
								},
								validates: {
										use_for: { actions: [:new] },
										rules: { required: true,  minlength: 8 },
										messages: {
												required: 'Поле «Пароль» обязательно для заполнения',
												minlength: 'Длина пароля должна быть не менее 8 символов',
										}
								}
						}, {
								caption: {text: 'Имя', class: 'first_name' },
								block: {
										name: 'field_for_model/input',
										content: {
												value: 'first_name'
										}
								},
								validates: {
										rules: { required: true },
										messages: {
												required: 'Поле «Имя» обязательно для заполнения'
										}
								}
						}, {
								caption: {text: 'Фамилия', class: 'second_name' },
								block: {
										name: 'field_for_model/input',
										content: {
												value: 'second_name'
										}
								},
								validates: {
										rules: { required: true },
										messages: {
												required: 'Поле «Фамилия» обязательно для заполнения'
										}
								}
						}, {
								caption: {text: 'Отчество', class: 'last_name' },
								block: {
										name: 'field_for_model/input',
										content: {
												value: 'last_name'
										}
								},
								validates: {
										rules: { required: true },
										messages: {
												required: 'Поле «Отчество» обязательно для заполнения'
										}
								}
						}, {
								caption: {text: 'Дата', class: 'date' },
								block: {
										name: 'field_for_model/input',
										view: 'date',
										content: {
												value: 'date',
												format: '%d.%m.%Y',
												js: 'date',
												js_format: 'dd.mm.yy',
												readonly: true
										}
								},
								validates: {
										rules: { required: true },
										messages: {
												required: 'Поле «Дата» обязательно для заполнения'
										}
								}
						}, {
								caption: {text: 'Аватар', class: 'avatar' },
								block: {
										name: 'field_for_model/file',
										content: {
												value: 'avatar',
												multiple: false
										}
								},
								validates: {
										rules: { required: true },
										messages: {
												required: 'Поле «Аватар» обязательно для заполнения'
										}
								}
						}, {
								caption: {text: 'Статус', class: 'user_status_id' },
								block: {
										name: 'field_for_model/select',
										view: 'with_plus',
										content: {
												value: 'user_status_id',
												options: 'UserStatus.all.map{ |datum| [datum.name, datum.id] }',
												new_url: 'new_admin_user_status_url',
												route: true
										}
								},
								validates: {
										rules: { required: true },
										messages: {
												required: 'Поле «Статус» обязательно для заполнения',
										}
								}
						}, {
								caption: {text: 'Роль', class: 'user_role_id' },
								block: {
										name: 'field_for_model/select',
										view: 'with_plus',
										content: {
												value: 'user_role_id',
												options: 'UserRole.all.map{ |datum| [datum.ru_name, datum.id] }',
												new_url: 'new_admin_user_role_url',
												route: true
										}
								},
								validates: {
										rules: { required: true },
										messages: {
												required: 'Поле «Роль» обязательно для заполнения',
										}
								}
						}, {
								caption: {text: 'Категории', class: 'categories' },
								block: {
										name: 'field_for_model/multi-select',
										content: {
												value: 'categories',
												options: 'Category.all.map{ |datum| [datum.name, datum.id] }',
										        multiple: true
										}
								},
								validates: {
										rules: { required: true },
										messages: {
												required: 'Поле «Категории» обязательно для заполнения',
										}
								}
						}]
	end

end