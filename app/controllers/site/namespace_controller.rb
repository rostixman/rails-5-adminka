module Site
	class NamespaceController < ApplicationController

		# ====================
		#  	 default layout
		# ====================
	    layout 'site/default/application'

		# ====================
		#   check controller
		# ====================
		def site_controller?
			true
		end
	end
end