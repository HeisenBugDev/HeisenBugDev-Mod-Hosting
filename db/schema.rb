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

ActiveRecord::Schema.define(version: 20140726181919) do

  create_table "artifacts", force: true do |t|
    t.string   "name"
    t.string   "artifact"
    t.integer  "build_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "downloads"
    t.string   "file_size"
  end

  add_index "artifacts", ["build_id"], name: "index_artifacts_on_build_id"

  create_table "builds", force: true do |t|
    t.integer  "build_number"
    t.string   "commit"
    t.string   "minecraft_version"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "branch"
    t.integer  "version_id"
    t.string   "build_state"
    t.string   "downloads"
    t.string   "main_download"
  end

  add_index "builds", ["build_number"], name: "index_builds_on_build_number"
  add_index "builds", ["project_id"], name: "index_builds_on_project_id"
  add_index "builds", ["version_id"], name: "index_builds_on_version_id"

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code_repo"
    t.string   "icon"
    t.string   "slug"
    t.string   "owner_sentence"
    t.string   "downloads"
    t.string   "download_sentence"
    t.string   "main_download"
    t.integer  "latest_release_build_id"
    t.integer  "latest_beta_build_id"
    t.integer  "latest_normal_build_id"
  end

  add_index "projects", ["slug"], name: "index_projects_on_slug", unique: true

  create_table "projects_users", id: false, force: true do |t|
    t.integer "user_id",    null: false
    t.integer "project_id", null: false
  end

  add_index "projects_users", ["project_id", "user_id"], name: "index_projects_users_on_project_id_and_user_id"
  add_index "projects_users", ["user_id", "project_id"], name: "index_projects_users_on_user_id_and_project_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "users", force: true do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "authentication_token"
    t.string   "slug"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token"
  add_index "users", ["name"], name: "index_users_on_name"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

  create_table "versions", force: true do |t|
    t.string   "version"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "versions", ["project_id"], name: "index_versions_on_project_id"

  create_table "wiki_articles", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  add_index "wiki_articles", ["category_id"], name: "index_wiki_articles_on_category_id"

  create_table "wiki_categories", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wiki_id"
  end

  create_table "wiki_wikis", force: true do |t|
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wiki_wikis", ["project_id"], name: "index_wiki_wikis_on_project_id"

end
