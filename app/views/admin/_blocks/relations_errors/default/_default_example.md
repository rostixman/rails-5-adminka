render_admin_block 'relations_errors', 'default', {
    object: content[:object],
    errors: content[:object].relations_errors
}