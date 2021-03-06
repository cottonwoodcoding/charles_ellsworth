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

ActiveRecord::Schema.define(version: 20150507020835) do

  create_table "admins", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "mailing_lists", force: true do |t|
    t.string "email"
  end

  create_table "promotion_texts", force: true do |t|
    t.text     "header_content"
    t.text     "footer_content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contribution_text"
  end

  create_table "raiseds", force: true do |t|
    t.float    "raised_value"
    t.float    "goal"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "donors"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "settings", force: true do |t|
    t.string "key"
    t.text   "value"
  end

  create_table "shows", force: true do |t|
    t.datetime "date"
    t.string   "venue"
    t.string   "location"
    t.string   "tickets"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "purchase_options"
  end

  create_table "videos", force: true do |t|
    t.string   "category"
    t.integer  "priority"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
