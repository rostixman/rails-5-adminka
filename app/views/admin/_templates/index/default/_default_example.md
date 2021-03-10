<%= render_template_block 'index', 'default', {
	configuration: @configuration,
	title: 'Заголовок',
	objects: @objects,
	breadcrumbs: [['Заголовок крошек', 'blank']],
	first_row_block_1: /*** определить блок, изначальное значение кнопка на создания ***/
	first_row_block_2: /*** определить блок, изначальное значение кнопка удаление всех ***/
	first_row_blocks:  /*** определить массив блоков, изначальное значение [content[:first_row_block_1], content[:first_row_block_2]] ***/
	action_block_1:    /*** определить блок, изначальное значение кнопка на редактирвоание ***/
	action_block_2:    /*** определить блок, изначальное значение кнопка на удаление ***/
	actions:           /*** определить массив блоков, изначальное значение [action_block_1, action_block_2] ***/
	panel_blocks:      /*** определить массив блоков, изначальное значение [table_for_model] ***/
	second_row_blocks: /*** определить массив блоков, изначальное значение [panel] ***/

} %>