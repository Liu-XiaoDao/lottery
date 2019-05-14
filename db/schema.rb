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

ActiveRecord::Schema.define(version: 20190514043209) do

  create_table "families", force: :cascade do |t|
    t.string "name"
    t.string "family_type"
    t.integer "user_list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "request_stats", force: :cascade do |t|
    t.string "path"
    t.integer "count"
    t.text "params_stats"
    t.float "max_time"
    t.float "min_time"
    t.float "avg_time"
    t.datetime "last_requested_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_lists", force: :cascade do |t|
    t.string "name", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_leader"
    t.integer "leader_id"
  end

  create_table "user_requests", force: :cascade do |t|
    t.integer "request_stat_id"
    t.string "url"
    t.float "time"
    t.integer "memory_usage"
    t.string "path"
    t.text "params"
    t.string "remote_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "attendance"
    t.string "avatar_url"
    t.boolean "is_active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age"
    t.integer "year"
    t.string "pre"
    t.string "phone"
    t.integer "lottery"
    t.integer "user_list_id"
  end

end
