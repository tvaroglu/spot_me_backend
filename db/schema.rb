# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2026_11_10_235700) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "date_time"
    t.string "activity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "gym_membership_id"
    t.index ["gym_membership_id"], name: "index_events_on_gym_membership_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "follower_id"
    t.bigint "followee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gym_memberships", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "yelp_gym_id"
    t.string "gym_name"
    t.index ["user_id", "yelp_gym_id"], name: "index_gym_memberships_on_user_id_and_yelp_gym_id", unique: true
    t.index ["user_id"], name: "index_gym_memberships_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "google_id"
    t.string "google_image_url"
    t.string "zip_code"
    t.string "summary"
    t.integer "goal"
    t.boolean "availability_morning", default: false, null: false
    t.boolean "availability_afternoon", default: false, null: false
    t.boolean "availability_evening", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name"
  end

  add_foreign_key "events", "gym_memberships"
  add_foreign_key "events", "users"
  add_foreign_key "gym_memberships", "users"
end
