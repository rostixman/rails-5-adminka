<%= render_template_block 'destroy', 'default', {
	configuration: @configuration,
	object: @object,
	modal_icon: 'octicon octicon-trashcan',
	modal_title: 'Заголовок'
	modal_body: 'Содержимое'
	destroy_link: 'admin_user_role_destroy'
	button_delete_success: /*** определить блок, изначальное значение [button_delete_success] ***/
} %>