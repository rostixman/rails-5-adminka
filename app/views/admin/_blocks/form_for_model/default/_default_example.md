{
      name: 'form_for_model',
      view: 'default',
      content: {
          class: 'form-horizontal group-border stripped',
          body_class: '',
          multipart: false,
          fields: @configuration.form_fields,
          model: @object,
          action: action,
          turboboost: true,
          footer: [{
                       visible: { roles: [], condition: '', actions: [] },
                       block: {
                           name: 'link',
                           view: 'button',
                           content: {
                               text: 'Сохранить',
                               link: '#',
                               router: false,
                               class: 'btn btn-success ladda-button like-jquery-validate-submit'
                           }
                       }
                   }, {
                       visible: { roles: [], condition: '', actions: [] },
                       block: {
                           name: 'link',
                           view: 'button',
                           content: {
                               text: 'Отмена',
                               link: 'admin_user_roles_url',
                               turbolink: false,
                               router: true,
                               class: 'btn btn-info ladda-button'
                           }
                       }
                   }]
      }
 }