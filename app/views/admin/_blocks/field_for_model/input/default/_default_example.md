visible: {roles: [:user], actions: [:new], condition: 'true'},
caption: {text: 'Название (rus)', class: 'ru_name' },
block: {
    name: 'field_for_model/input',
    content: {
        value: 'ru_name',
        default_value: '',
        placeholder: '',
        tooltip_text: 'tooltip text',
        help_text: 'help text'
    }
},
validates: {
    use_for: { roles: [], actions: [], condition: 'true' },
    rules: { required: true },
    messages: {
        required: 'Поле «Название (eng)» обязательно для заполнения'
    }
}