// copy in you form tag

<%= render_admin_block 'admin/_blocks/field_for_model/_errors',
                       'default', {
                                model: content[:model]
                        }, abs: true %>