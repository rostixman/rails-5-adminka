# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160809092743) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entity_files", force: :cascade do |t|
    t.string   "entity"
    t.integer  "entity_id"
    t.string   "name"
    t.string   "title"
    t.string   "file"
    t.string   "content_type"
    t.string   "original_filename"
    t.string   "size"
    t.integer  "main",              null: false
    t.string   "locale",            null: false
    t.integer  "weight",            null: false
    t.text     "desc"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "entity_files", ["user_id"], name: "index_entity_files_on_user_id", using: :btree

  create_table "user_auth_tokens", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "devise"
    t.string   "devise_token"
    t.string   "devise_type"
    t.string   "auth_token"
    t.integer  "notify"
    t.datetime "expiration_date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "user_auth_tokens", ["user_id"], name: "index_user_auth_tokens_on_user_id", using: :btree

  create_table "user_roles", force: :cascade do |t|
    t.string   "name"
    t.string   "ru_name"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  null: false
    t.string   "encrypted_password",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "user_status_id",         null: false
    t.integer  "user_role_id",           null: false
    t.string   "first_name"
    t.string   "second_name"
    t.string   "last_name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.datetime "date"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_categories", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "users_categories", ["category_id"], name: "index_users_categories_on_category_id", using: :btree
  add_index "users_categories", ["user_id"], name: "index_users_categories_on_user_id", using: :btree

  add_foreign_key "entity_files", "users"
  add_foreign_key "user_auth_tokens", "users"
  add_foreign_key "users_categories", "categories"
  add_foreign_key "users_categories", "users"
end
