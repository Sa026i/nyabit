# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_11_08_084051) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "board_achievements", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.bigint "habit_log_id", null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_board_achievements_on_board_id"
    t.index ["habit_log_id"], name: "index_board_achievements_on_habit_log_id"
  end

  create_table "boards", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "posted_on", null: false
    t.string "title"
    t.text "body"
    t.boolean "is_visibility", default: true
    t.integer "likes_count", default: 0
    t.integer "achieved_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_boards_on_user_id"
  end

  create_table "habit_logs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "habit_id", null: false
    t.date "logged_on", null: false
    t.string "partner_code"
    t.string "habit_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["habit_id"], name: "index_habit_logs_on_habit_id"
    t.index ["user_id"], name: "index_habit_logs_on_user_id"
  end

  create_table "habits", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "partner_id", null: false
    t.string "title", null: false
    t.boolean "is_active", default: true
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["partner_id"], name: "index_habits_on_partner_id"
    t.index ["user_id"], name: "index_habits_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "board_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_likes_on_board_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "partners", force: :cascade do |t|
    t.string "name"
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "role"
    t.string "provider", limit: 64
    t.string "uid"
    t.string "x_account"
    t.string "instagram_account"
    t.string "facebook_account"
    t.boolean "email_reminder_enabled", default: false
    t.string "timezone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "board_achievements", "boards"
  add_foreign_key "board_achievements", "habit_logs"
  add_foreign_key "boards", "users"
  add_foreign_key "habit_logs", "habits"
  add_foreign_key "habit_logs", "users"
  add_foreign_key "habits", "partners"
  add_foreign_key "habits", "users"
  add_foreign_key "likes", "boards"
  add_foreign_key "likes", "users"
  add_foreign_key "profiles", "users"
end
