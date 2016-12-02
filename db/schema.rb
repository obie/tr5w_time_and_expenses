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

ActiveRecord::Schema.define(version: 20161130204015) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authem_sessions", force: :cascade do |t|
    t.string   "role",                    null: false
    t.string   "subject_type",            null: false
    t.integer  "subject_id",              null: false
    t.string   "token",        limit: 60, null: false
    t.datetime "expires_at",              null: false
    t.integer  "ttl",                     null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["expires_at", "subject_type", "subject_id"], name: "index_authem_sessions_subject", using: :btree
    t.index ["expires_at", "token"], name: "index_authem_sessions_on_expires_at_and_token", unique: true, using: :btree
  end

  create_table "avatars", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_avatars_on_user_id", using: :btree
  end

  create_table "billable_weeks", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "billing_code_id"
    t.integer  "timesheet_id"
    t.datetime "start_date"
    t.integer  "monday_hours"
    t.integer  "tuesday_hours"
    t.integer  "wednesday_hours"
    t.integer  "thursday_hours"
    t.integer  "friday_hours"
    t.integer  "saturday_hours"
    t.integer  "sunday_hours"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["billing_code_id"], name: "index_billable_weeks_on_billing_code_id", using: :btree
    t.index ["client_id"], name: "index_billable_weeks_on_client_id", using: :btree
    t.index ["timesheet_id"], name: "index_billable_weeks_on_timesheet_id", using: :btree
  end

  create_table "billing_codes", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "code"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["client_id"], name: "index_billing_codes_on_client_id", using: :btree
  end

  create_table "billing_codes_timesheets", id: false, force: :cascade do |t|
    t.integer "billing_code_id", null: false
    t.integer "timesheet_id",    null: false
    t.index ["billing_code_id", "timesheet_id"], name: "billing_timesheets", using: :btree
    t.index ["timesheet_id", "billing_code_id"], name: "timesheets_billing", using: :btree
  end

  create_table "businesses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "total_spend"
    t.integer  "hottest_spend_day"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contact_cards", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "contact_type"
    t.integer  "contact_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["client_id"], name: "index_contact_cards_on_client_id", using: :btree
    t.index ["contact_type", "contact_id"], name: "index_contact_cards_on_contact_type_and_contact_id", using: :btree
  end

  create_table "expense_reports", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_expense_reports_on_user_id", using: :btree
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "positions", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "player_id"
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_positions_on_player_id", using: :btree
    t.index ["team_id"], name: "index_positions_on_team_id", using: :btree
  end

  create_table "related_billing_codes", id: false, force: :cascade do |t|
    t.integer "first_billing_code_id",  null: false
    t.integer "second_billing_code_id", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id"
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "coach"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timesheets", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "approver_id"
    t.boolean  "submitted",    default: false
    t.integer  "lock_version", default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["user_id"], name: "index_timesheets_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "login"
    t.string   "name"
    t.string   "email"
    t.jsonb    "properties"
    t.string   "password_digest",                  null: false
    t.string   "password_reset_token",  limit: 60, null: false
    t.string   "token"
    t.boolean  "authorized_approver"
    t.datetime "timesheets_updated_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["client_id"], name: "index_users_on_client_id", using: :btree
  end

end
