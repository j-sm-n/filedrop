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

ActiveRecord::Schema.define(version: 20161026171039) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "document_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["document_id"], name: "index_comments_on_document_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "containers", force: :cascade do |t|
    t.integer  "folder_id"
    t.integer  "containable_id"
    t.string   "containable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["folder_id"], name: "index_containers_on_folder_id", using: :btree
  end

  create_table "documents", force: :cascade do |t|
    t.string   "filename"
    t.string   "content_type"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "url"
    t.index ["user_id"], name: "index_documents_on_user_id", using: :btree
  end

  create_table "external_applications", force: :cascade do |t|
    t.string   "name"
    t.string   "api_key"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_external_applications_on_user_id", using: :btree
  end

  create_table "folder_permissions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "folder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["folder_id"], name: "index_folder_permissions_on_folder_id", using: :btree
    t.index ["user_id"], name: "index_folder_permissions_on_user_id", using: :btree
  end

  create_table "folders", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "permission_level", default: 0
    t.index ["user_id"], name: "index_folders_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "role",            default: 0
    t.string   "sms_number"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "authy_id"
    t.integer  "status",          default: 0
  end

  add_foreign_key "comments", "documents"
  add_foreign_key "comments", "users"
  add_foreign_key "containers", "folders"
  add_foreign_key "documents", "users"
  add_foreign_key "external_applications", "users"
  add_foreign_key "folder_permissions", "folders"
  add_foreign_key "folder_permissions", "users"
  add_foreign_key "folders", "users"
end
