class CreateEntityFiles < ActiveRecord::Migration
  def change
    create_table :entity_files do |t|
      t.string :entity
      t.integer :entity_id
      t.string :name
      t.string :title
      t.string :file
      t.string :content_type
      t.string :original_filename
      t.string :size
      t.integer :main, null: false, defaul: 0
      t.string :locale, null: false, defaul: 'ru'
      t.integer :weight, null: false, defaul: 500
      t.text :desc
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
