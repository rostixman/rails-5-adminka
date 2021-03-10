Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( admin/default/external_page.scss admin/default/external_page.js )
Rails.application.config.assets.precompile += %w( admin/default/partials/plugins/core.js )
Rails.application.config.assets.precompile += %w[*.png *.jpg *.jpeg *.gif *.ico]
Rails.application.config.assets.precompile += %w[*.otf *.eot *.woff *.woff2 *.ttf *.svg]