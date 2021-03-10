<%
   content_for :title, @configuration.signatures[:elements]
   breadcrumb :general, [[@configuration.signatures[:elements], 'blank']]
%>

<%= render_admin_block 'row', 'default', {
	class: 'mb10',
	blocks: [{
		         name: 'link',
		         view: 'button',
		         content: {
			         text: "<i class=\"octicon octicon-plus\"></i>&nbsp;&nbsp; #{@configuration.signatures[:add_element]}",
			         link: 'new_admin_user_role_url',
			         router: true,
			         turbolinks: true,
			         class: 'btn ladda-button btn-system'
		         }
	         }, {
		         name: 'link',
		         view: 'button',
		         content: {
			         text: "<i class=\"octicon octicon-plus\"></i>&nbsp;&nbsp; Удалить выбранное",
			         link: '#',
			         router: false,
			         class: 'btn btn-danger btn-checker button_delete_all',
			         style: 'display: none;',
			         js: 'button_delete_all'
		         }
	         }]
} %>

<%= render_admin_block 'row', 'default', {
	blocks: [{
		         name: 'panel',
		         content: {
			         class: '',
			         body_class: 'pn',
			         title: @configuration.signatures[:elements],
			         blocks: [{
				                  name: 'table_for_model',
				                  view: 'data_table',
				                  content: {
					                  checker: true,
					                  columns: @configuration.table_properties,
					                  id: 'table-user_roles',
					                  class: 'table table-hover no-more-tables', # no-more-tables для адаптивной таблицы
					                  rows: @objects,
					                  data_attr: {
						                  sort_disable: '[0, 1]',
						                  sort_column: 2,
						                  sort_default: 'asc',
						                  display_length: 25
					                  },
					                  actions: [{
						                            name: 'dropdown',
						                            content: {
							                            text: '<i class="imoon imoon-menu2"></i>',
							                            link: '#',
							                            router: false,
							                            class: 'btn btn-xs btn-default',
							                            exclusion: [],
							                            blocks: [{
								                                     name: 'link',
								                                     view: 'button',
								                                     content: {
									                                     text: 'Некоторая кнопка',
									                                     class: 'btn super-btn text-left',
									                                     exclusion: []
								                                     }
							                                     }, {
								                                     name: 'link',
								                                     view: 'button',
								                                     content: {
									                                     text: 'Еще кнопка',
									                                     class: 'btn super-btn text-left',
									                                     exclusion: []
								                                     }
							                                     }]
						                            }
					                            },{
						                            name: 'link',
						                            view: 'button',
						                            content: {
							                            text: '<i class="fa fa-pencil"></i>',
							                            link: 'edit_admin_user_role_path(content[:row])',
							                            router: true,
							                            turbolinks: true,
							                            class: 'btn btn-xs ladda-button btn-system',
							                            exclusion: []
						                            }
					                            }, {
						                            name: 'link',
						                            view: 'button',
						                            content: {
							                            text: '<i class="octicon octicon-x"></i>',
							                            link: 'admin_user_role_path(content[:row], format: :html)',
							                            router: true,
							                            method: :delete,
							                            class: 'btn btn-xs btn-danger btn-remove btn-remove-in-modal ladda-button',
							                            exclusion: []
						                            }
					                            }]
				                  }
			                  }]
		         }
	         }]
} %>