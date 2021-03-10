class AdminSetting < BaseSetting

	def construct
		@menu = {admin: [], user: []}

		@menu[:admin] = [{
							 name: 'Меню',
							 link: 'label',
							 options: {
								 class: 'sidebar-label pt20'
							 }
						 }, {
							 name: 'Рабочий стол',
							 link: 'admin_dashboard_path',
							 options: {
								 icon: 'imoon imoon-home'
							 }
						 }, {
							 name: 'Пользователи',
							 link: 'admin_users_path',
							 options: {
								 icon: 'icon-zoom2 icon-users2'
							 }
						 }, {
							 name: 'Файлы',
							 link: 'admin_entity_files_path',
							 options: {
								 icon: 'imoon imoon-file'
							 }
						 }, {
							 name: 'Справ. пользователей',
							 link: 'label',
							 options: {
								 class: 'sidebar-label pt20'
							 }
						 }, {
							 name: 'Роли',
							 link: 'admin_user_roles_path',
							 options: {
								 icon: 'octicon octicon-dash'
							 }
						 }, {
							 name: 'Статусы',
							 link: 'admin_user_statuses_path',
							 options: {
								 icon: 'octicon octicon-dash'
							 }
						 }, {
							 name: 'Категории',
							 link: 'admin_categories_path',
							 options: {
								 icon: 'octicon octicon-dash'
							 }
						 }]

		@logo = '<span class="octicon octicon-ruby"></span>&nbsp;&nbsp;<b>Mint</b>Admin'
		@copyright = "© #{Time.now.strftime('%Y')} MintAdmin"
	end
end