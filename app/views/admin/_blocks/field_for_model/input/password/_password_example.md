{
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
                        required: 'Поле Пароль обязательно для заполнения',
                        minlength: 'Длина пароля должна быть не менее 8 символов',
                }
        }
}