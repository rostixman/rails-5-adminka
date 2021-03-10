{
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
                        required: 'Поле E-mail обязательно для заполнения',
                        regex: 'Некорректно указан E-mail'
                }
        }
}