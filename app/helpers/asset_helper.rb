module AssetHelper
	def inline_js(content, attrs = '')
		content_for :javascript do
			"<script #{attrs}>#{raw Uglifier.new.compile(content)}</script>".html_safe
		end
	end
end