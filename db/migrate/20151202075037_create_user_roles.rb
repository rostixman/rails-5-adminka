class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.string :name
      t.string :ru_name
      t.boolean :active

      t.timestamps null: false
    end
  end
end
