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

ActiveRecord::Schema.define(version: 20140505180417) do

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
  end

  add_index "builds", ["build_number"], name: "index_builds_on_build_number"
  add_index "builds", ["project_id"], name: "index_builds_on_project_id"
  add_index "builds", ["version_id"], name: "index_builds_on_version_id"

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code_repo"
    t.string   "subtitle"
    t.string   "icon"
  end

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
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token"
  add_index "users", ["name"], name: "index_users_on_name"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

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
    t.string   "body"
    t.integer  "wiki_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "build_id"
    t.integer  "version_id"
    t.string   "category_id"
  end

  add_index "wiki_articles", ["build_id"], name: "index_wiki_articles_on_build_id"
  add_index "wiki_articles", ["category_id"], name: "index_wiki_articles_on_category_id"
  add_index "wiki_articles", ["version_id"], name: "index_wiki_articles_on_version_id"
  add_index "wiki_articles", ["wiki_id"], name: "index_wiki_articles_on_wiki_id"

  create_table "wiki_categories", force: true do |t|
    t.string   "title"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wiki_id"
  end

  add_index "wiki_categories", ["parent_id"], name: "index_wiki_categories_on_parent_id"

  create_table "wiki_wikis", force: true do |t|
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "repo"
  end

  add_index "wiki_wikis", ["project_id"], name: "index_wiki_wikis_on_project_id"

end
