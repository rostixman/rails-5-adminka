module AdminHelper
	def render_admin_block(name, view, content, options = {})
		name ||= ''
		view ||= 'default'
		options[:abs] ||= false

		path = "admin/_blocks/#{name}/#{view}/#{view}"
		path = "#{name}/#{view}/#{view}" if options[:abs]

		render path, content: content
	end

	def render_template_block(name, view, content, options = {})
		name ||= ''
		view ||= 'default'

		path = "admin/_templates/#{name}/#{view}/#{view}"

		render path, content: content
	end
end
