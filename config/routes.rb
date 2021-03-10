Rails.application.routes.draw do

	# user
	devise_for :users,
			   controllers: {
					   sessions: 'user/sessions',
					   registrations: 'user/registrations',
					   passwords: 'user/passwords'
			   },
			   path: 'admin',
			   path_names: {
					   sign_in: 'login',
					   sign_out: 'logout',
					   password: 'password',
					   confirmation: 'verification',
					   unlock: 'unblock',
					   registration: 'register',
					   sign_up: 'cmon_let_me_in'
			   }

	# site
	namespace :site, path: '' do
		root to: 'main#index'
	end

	# admin
	namespace :admin do
		root to: 'namespace#base'
		get 'dashboard', to: 'dashboard#index'
		resources :users
		resources :user_roles, 		path: '/roles'
		resources :user_statuses, 	path: '/user-statuses'
		resources :categories, 	    path: '/categories'
		resources :entity_files, 	path: '/files' do
			collection do
				post 'upload', to: 'entity_files#upload', as: 'upload'
				post 'remove', to: 'entity_files#remove', as: 'remove'
			end
		end

		# ajax
		post 'reload-select-data', to: 'namespace#reload_select_data'
	end
	
	# api
	namespace :api, defaults: {format: 'json'} do
		namespace :v1 do
			# sessions
			post    'sessions', to: 'sessions#create'
			delete  'sessions', to: 'sessions#destroy'
			
			# users
			get  'users', to: 'users#list'
			get  'users/count', to: 'users#only_count'
			get  'users/:token', to: 'users#show'
			post 'users', to: 'users#create'
			
			# passwords
			put 'passwords/recovery', to: 'passwords#recovery'

			# notifications
			post 'notifications', to: 'notifications#create'
			delete 'notifications', to: 'notifications#destroy'
		end
	end
end
