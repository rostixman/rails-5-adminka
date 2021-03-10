def firstly
	UserStatus.create([{name: 'Активен'},
					   {name: 'Не активен'}])

	UserRole.create([{name: 'admin', ru_name: 'Администратор'},
					 {name: 'user', ru_name: 'Пользователь'}])

	user = User.new({email: 'mintrocket@admin.com',
					 password: 'VjbsYFEX47gN',
					 password_confirmation: 'VjbsYFEX47gN',
					 first_name: 'Ильин',
					 second_name: 'Ростислав',
					 last_name: 'Вячеславович',
					 sign_in_count: 0,
					 user_role_id: UserRole.find_by_name('admin').id,
					 user_status_id: UserStatus.find_by_name('Активен').id})
	user.save
end

def test_user_roles
	UserRole.where('id > 2').delete_all

	$i = 0
	$num = 120
	while $i < $num  do
		UserRole.create([{name: "user_role_#{$i}", ru_name: "роль № #{$i}"}])
		$i +=1
	end
end

def full_seed
	firstly
	# test_user_roles
end

full_seed