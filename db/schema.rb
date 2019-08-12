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

ActiveRecord::Schema.define(version: 2019_07_21_101755) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.boolean "language_de"
    t.boolean "language_en"
    t.boolean "attended_before"
    t.boolean "rejected_before"
    t.integer "level"
    t.text "comments"
    t.string "os"
    t.boolean "needs_computer"
    t.text "tutorials"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "event_id"
    t.boolean "attendance_confirmed", default: false, null: false
    t.string "random_id"
    t.date "selected_on"
    t.integer "sequence_number"
    t.integer "state", default: 0, null: false
    t.boolean "attended", default: false
    t.index ["event_id"], name: "index_applications_on_event_id"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "place"
    t.date "scheduled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "application_start"
    t.date "application_end"
    t.date "confirmation_date"
    t.boolean "selection_complete", default: false, null: false
    t.string "start_time", null: false
    t.string "end_time", null: false
    t.text "application_mail"
    t.text "selection_mail"
    t.text "rejection_mail"
    t.text "reminder_mail"
    t.text "reminder_mail_subject"
    t.text "application_mail_subject"
    t.text "selection_mail_subject"
    t.text "rejection_mail_subject"
    t.text "waiting_list_mail"
    t.text "waiting_list_mail_subject"
    t.integer "confirmation_deadline", default: 5, null: false
    t.integer "reminder_date", default: 2, null: false
    t.text "reminder_attendance_mail"
    t.text "reminder_attendance_mail_subject"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

end
