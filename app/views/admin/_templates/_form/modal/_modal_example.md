<%= render_template_block 'destroy', 'default', {
	configuration: @configuration,
	action: action
	panel_title: 'Заголовок панели'
	title: 'Заголовок'
	object: @object
	footer_action_block_1: /*** определить блок ***/
	footer_action_block_2: /*** определить блок ***/
	footer_actions:        /*** определить массив блоков, default: [footer_action_block_1, footer_action_block_2] ***/
	row_blocks:            /*** определить массив блоков, default: [panel] ***/
} %>