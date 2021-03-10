//

{
    caption: { /* ... */ },
    visible: { /* ... */ },
    block: {
        name: 'cells/text',
        view: 'default',
        content: {
            value: 'content[:row].id',  // значение в ячейки
            fotmat: '%d.%m.%Y'          // формат вывода даты
            prefix: '',                 // текст перед value
            postfix: ''                 // текст после value
        }
    }
}