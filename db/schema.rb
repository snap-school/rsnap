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

ActiveRecord::Schema.define(version: 20150707153946) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chapter_mission_manifests", force: true do |t|
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "chapter_id"
    t.integer  "mission_id"
  end

  create_table "chapters", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "small_description"
    t.string   "youtube"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "chapter_order",     default: 0
    t.integer  "teacher_id"
  end

  create_table "course_chapter_manifests", force: true do |t|
    t.integer  "course_id"
    t.integer  "chapter_id"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "teacher_id"
  end

  create_table "file_missions", force: true do |t|
    t.integer  "mission_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "file_missions", ["mission_id"], name: "index_file_missions_on_mission_id", using: :btree

  create_table "missions", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "source_code_file_name"
    t.string   "source_code_content_type"
    t.integer  "source_code_file_size"
    t.datetime "source_code_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "small_description"
    t.string   "youtube"
    t.boolean  "needs_check",              default: false
    t.integer  "teacher_id"
  end

  create_table "programs", force: true do |t|
    t.string   "source_code_file_name"
    t.string   "source_code_content_type"
    t.integer  "source_code_file_size"
    t.datetime "source_code_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "mission_id"
    t.integer  "state",                    default: 0
  end

  add_index "programs", ["mission_id"], name: "index_programs_on_mission_id", using: :btree
  add_index "programs", ["user_id"], name: "index_programs_on_user_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "source_code_file_name"
    t.string   "source_code_content_type"
    t.integer  "source_code_file_size"
    t.datetime "source_code_updated_at"
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "student_courses", force: true do |t|
    t.integer "student_id"
    t.integer "course_id"
  end

  add_index "student_courses", ["student_id", "course_id"], name: "index_student_courses_on_student_id_and_course_id", using: :btree

  create_table "students", force: true do |t|
    t.integer "user_id"
  end

  add_index "students", ["user_id"], name: "index_students_on_user_id", unique: true, using: :btree

  create_table "teachers", force: true do |t|
    t.integer "user_id"
  end

  add_index "teachers", ["user_id"], name: "index_teachers_on_user_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
