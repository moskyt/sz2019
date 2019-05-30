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

ActiveRecord::Schema.define(version: 20190530133753) do

  create_table "parameters", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",                          limit: 255
    t.integer  "number",                        limit: 4
    t.string   "district",                      limit: 255
    t.datetime "ts_registered"
    t.datetime "ts_rules_submitted"
    t.datetime "ts_about_submitted"
    t.datetime "ts_departed"
    t.datetime "ts_arrived"
    t.text     "participants_json",             limit: 65535
    t.integer  "points",                        limit: 4
    t.string   "preference_departure",          limit: 255
    t.integer  "points_before_about",           limit: 4
    t.integer  "points_before_rules",           limit: 4
    t.integer  "points_before_register",        limit: 4
    t.integer  "points_survival_travel",        limit: 4
    t.integer  "points_survival_dinner",        limit: 4
    t.integer  "points_survival_night_spot",    limit: 4
    t.integer  "points_survival_night_tent",    limit: 4
    t.integer  "points_survival_night_cleanup", limit: 4
    t.integer  "points_survival_night_packing", limit: 4
    t.integer  "points_survival_night_gps",     limit: 4
    t.integer  "points_survival_night_moral",   limit: 4
    t.integer  "points_race_01",                limit: 4
    t.integer  "points_race_02",                limit: 4
    t.integer  "points_race_03",                limit: 4
    t.integer  "points_race_04",                limit: 4
    t.integer  "points_race_05",                limit: 4
    t.integer  "points_race_06",                limit: 4
    t.integer  "points_race_07",                limit: 4
    t.integer  "points_race_08",                limit: 4
    t.integer  "points_race_09",                limit: 4
    t.integer  "points_race_10",                limit: 4
    t.integer  "points_race_11",                limit: 4
    t.integer  "points_race_12",                limit: 4
    t.integer  "points_race_13",                limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "uid",                           limit: 255
    t.string   "category",                      limit: 255
    t.string   "about_photo_file_name",         limit: 255
    t.string   "about_photo_content_type",      limit: 255
    t.integer  "about_photo_file_size",         limit: 8
    t.datetime "about_photo_updated_at"
    t.text     "replies_register",              limit: 65535
    t.text     "replies_rules",                 limit: 65535
    t.datetime "ts_rules_started"
    t.datetime "ts_rules_done"
    t.string   "initial_emails",                limit: 255
    t.datetime "ts_survival_center"
    t.datetime "ts_survival_hotspot"
    t.string   "checkin_photo_file_name",       limit: 255
    t.string   "checkin_photo_content_type",    limit: 255
    t.integer  "checkin_photo_file_size",       limit: 8
    t.datetime "checkin_photo_updated_at"
    t.text     "checkin_data",                  limit: 65535
    t.text     "medical_data",                  limit: 65535
    t.text     "new_supervisor_data",           limit: 65535
  end

end
