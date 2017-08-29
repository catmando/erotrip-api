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

ActiveRecord::Schema.define(version: 20170829103922) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"
  enable_extension "unaccent"
  enable_extension "citext"
  enable_extension "hstore"

  create_table "groups", id: :integer, default: -> { "nextval('groups_not_uuid_seq'::regclass)" }, force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "kinds"
  end

  create_table "hyperloop_connections", force: :cascade do |t|
    t.string "channel"
    t.string "session"
    t.datetime "created_at"
    t.datetime "expires_at"
    t.datetime "refresh_at"
  end

  create_table "hyperloop_queued_messages", force: :cascade do |t|
    t.text "data"
    t.integer "connection_id"
  end

  create_table "names", force: :cascade do |t|
    t.integer "year_of_birth"
    t.string "kind"
    t.string "location"
    t.string "location_lat"
    t.string "location_lon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :integer, default: -> { "nextval('users_not_uuid_seq'::regclass)" }, force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "kind"
    t.string "name"
    t.integer "birth_year"
    t.string "name_second_person"
    t.integer "birth_year_second_person"
    t.string "city"
    t.integer "pin"
    t.boolean "terms_acceptation"
    t.boolean "private"
    t.json "searched_kinds"
    t.integer "weight"
    t.integer "height"
    t.string "body"
    t.boolean "smoker"
    t.boolean "alcohol"
    t.string "avatar"
    t.string "verification_photo"
    t.string "my_expectations"
    t.text "about_me"
    t.text "interests"
    t.text "likes"
    t.text "dislikes"
    t.text "ideal_partner"
    t.boolean "verified"
    t.index ["alcohol"], name: "index_users_on_alcohol"
    t.index ["body"], name: "index_users_on_body"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["kind"], name: "index_users_on_kind"
    t.index ["pin"], name: "index_users_on_pin"
    t.index ["private"], name: "index_users_on_private"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["terms_acceptation"], name: "index_users_on_terms_acceptation"
    t.index ["verified"], name: "index_users_on_verified"
  end

end
