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

ActiveRecord::Schema.define(version: 20160217060650) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_photos", force: :cascade do |t|
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.boolean "accepted"
    t.string  "number"
    t.string  "eta"
    t.string  "place_id"
  end

  add_index "event_users", ["event_id"], name: "index_event_users_on_event_id", using: :btree
  add_index "event_users", ["user_id"], name: "index_event_users_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "caption"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.string   "event_address"
    t.datetime "time_at"
    t.string   "place_id"
    t.boolean  "scheduled"
    t.string   "eta"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "invitees", force: :cascade do |t|
    t.boolean  "attending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "event_id"
    t.integer  "user_id"
  end

  add_index "invitees", ["event_id"], name: "index_invitees_on_event_id", using: :btree
  add_index "invitees", ["user_id"], name: "index_invitees_on_user_id", using: :btree

  create_table "main_images", force: :cascade do |t|
    t.string   "url"
    t.string   "format"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "event_id"
  end

  add_index "main_images", ["event_id"], name: "index_main_images_on_event_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "phone"
    t.string   "fname"
    t.string   "lname_initial"
    t.string   "email"
    t.string   "prof_img_url"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "password_digest"
    t.string   "local_ip"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "bio"
    t.string   "uber_access_token"
  end

  add_index "users", ["phone", "email"], name: "index_users_on_phone_and_email", unique: true, using: :btree

  add_foreign_key "events", "users"
  add_foreign_key "invitees", "events"
  add_foreign_key "invitees", "users"
  add_foreign_key "main_images", "events"
end
