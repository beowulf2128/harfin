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

ActiveRecord::Schema.define(version: 20190607192446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "persons", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.date "birthdate"
    t.boolean "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "privileges", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "privileges_roles", id: false, force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "privilege_id", null: false
  end

  create_table "registrations", id: :serial, force: :cascade do |t|
    t.boolean "registered"
    t.string "reg_type"
    t.string "group_assignment"
    t.string "table_assignment"
    t.string "team_name"
    t.integer "person_id"
    t.integer "sessionyear_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_registrations_on_person_id"
    t.index ["sessionyear_id"], name: "index_registrations_on_sessionyear_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "scores", force: :cascade do |t|
    t.bigint "scoretype_id"
    t.integer "point_value"
    t.bigint "sessionday_id"
    t.date "score_date"
    t.string "team_name"
    t.integer "clubber_id"
    t.integer "recorded_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "truthbooksignature_id"
    t.index ["scoretype_id"], name: "index_scores_on_scoretype_id"
    t.index ["sessionday_id"], name: "index_scores_on_sessionday_id"
  end

  create_table "scoretypes", force: :cascade do |t|
    t.string "name"
    t.integer "suggested_point_value"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessiondays", id: :serial, force: :cascade do |t|
    t.integer "sessionyear_id"
    t.datetime "sd_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_club_night"
    t.index ["sessionyear_id"], name: "index_sessiondays_on_sessionyear_id"
  end

  create_table "sessionyears", id: :serial, force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "theme"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "truthbooks", force: :cascade do |t|
    t.string "name"
    t.string "edition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "truthbooksections", force: :cascade do |t|
    t.string "unit"
    t.string "section"
    t.integer "sort"
    t.integer "truthbook_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "scoretype_id"
  end

  create_table "truthbooksignatures", force: :cascade do |t|
    t.integer "truthbooksection_id"
    t.integer "sessionday_id"
    t.integer "clubber_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "last_login_at"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_users_on_person_id"
  end

  add_foreign_key "registrations", "persons"
  add_foreign_key "registrations", "sessionyears"
  add_foreign_key "scores", "persons", column: "clubber_id"
  add_foreign_key "scores", "persons", column: "recorded_by_id"
  add_foreign_key "scores", "scoretypes"
  add_foreign_key "scores", "sessiondays"
  add_foreign_key "sessiondays", "sessionyears"
end
