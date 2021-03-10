caption: {text: 'Описание', class: 'desc' },
block: {
        name: 'field_for_model/textarea',
        content: {
                value: 'desc',
                placeholder: 'Описание да да да'
        }
},
validates: {
        rules: { required: true },
        messages: {
                required: 'Поле «Описание» обязательно для заполнения',
        }
}