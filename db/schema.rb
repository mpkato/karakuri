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

ActiveRecord::Schema.define(version: 20151010133133) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "assigns", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "task_set_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "assigns", ["task_set_id"], name: "index_assigns_on_task_set_id"
  add_index "assigns", ["user_id"], name: "index_assigns_on_user_id"

  create_table "behaviors", force: :cascade do |t|
    t.integer  "status"
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "behaviors", ["task_id"], name: "index_behaviors_on_task_id"
  add_index "behaviors", ["user_id"], name: "index_behaviors_on_user_id"

  create_table "task_results", force: :cascade do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.text     "submitted_data"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "task_results", ["task_id"], name: "index_task_results_on_task_id"
  add_index "task_results", ["user_id"], name: "index_task_results_on_user_id"

  create_table "task_sets", force: :cascade do |t|
    t.string   "label"
    t.integer  "task_template_id"
    t.integer  "tasks_count",      default: 0
    t.integer  "assigns_count",    default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "task_sets", ["task_template_id"], name: "index_task_sets_on_task_template_id"

  create_table "task_templates", force: :cascade do |t|
    t.string   "label"
    t.string   "title_template"
    t.text     "form_template"
    t.integer  "task_sets_count", default: 0
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "task_templates", ["user_id"], name: "index_task_templates_on_user_id"

  create_table "tasks", force: :cascade do |t|
    t.text     "yaml_data"
    t.integer  "task_set_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "tasks", ["task_set_id"], name: "index_tasks_on_task_set_id"

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username"

end
