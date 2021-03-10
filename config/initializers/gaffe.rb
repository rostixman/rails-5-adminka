Gaffe.configure do |config|
	config.errors_controller = {
		%r[^/api/] => 'Api::V1::ErrorsController',
		%r[^/] => 'Site::ErrorsController',
	}
end

Gaffe.enable!