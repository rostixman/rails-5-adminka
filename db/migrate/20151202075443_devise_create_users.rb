class DeviseCreateUsers < ActiveRecord::Migration
	def change
		create_table(:users) do |t|

			## Database authenticatable
			t.string :email, null: false, modal: ''
			t.string :encrypted_password, null: false, modal: ''

			## Recoverable
			t.string   :reset_password_token
			t.datetime :reset_password_sent_at

			## Rememberable
			t.datetime :remember_created_at

			## Trackable
			t.integer :sign_in_count, defaul: 0
			t.datetime :current_sign_in_at
			t.datetime :last_sign_in_at
			t.string   :current_sign_in_ip
			t.string   :last_sign_in_ip

			## Profile
			t.references :user_status, null: false
			t.references :user_role, null: false
			t.string  :first_name
			t.string  :second_name
			t.string  :last_name

			t.timestamps null: false
		end

		add_index :users, :email,                unique: true
		add_index :users, :reset_password_token, unique: true
	end
end
