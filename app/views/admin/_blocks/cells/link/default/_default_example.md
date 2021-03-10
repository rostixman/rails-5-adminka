//

{
    caption: { /* ... */ },
    visible: { /* ... */ },
    block: {
        name: 'cells/text',
        view: 'default',
        content: {
            value: 'content[:row].full_name',               // текст
            link: 'edit_admin_user_path(content[:row].id)', // ссылка
            route: true                                     // является ли алиасом routers.rb
            prefix: '',                                     // текст перед value
            postfix: ''                                     // текст после value
        }
    }
}