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

ActiveRecord::Schema.define(version: 20190519174958) do

  create_table "teams", force: :cascade do |t|
    t.string   "name",                     limit: 255
    t.integer  "number",                   limit: 4
    t.string   "district",                 limit: 255
    t.string   "stage",                    limit: 255
    t.datetime "ts_registered"
    t.datetime "ts_rules_submitted"
    t.datetime "ts_about_submitted"
    t.datetime "ts_departed"
    t.datetime "ts_arrived"
    t.text     "participants_json",        limit: 65535
    t.integer  "points",                   limit: 4
    t.integer  "points_about",             limit: 4
    t.integer  "points_rules",             limit: 4
    t.string   "preference_departure",     limit: 255
    t.integer  "preference_hotspot",       limit: 4
    t.string   "departure",                limit: 255
    t.string   "trail",                    limit: 255
    t.integer  "hotspot",                  limit: 4
    t.integer  "points_dinner",            limit: 4
    t.integer  "points_cleanup",           limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "uid",                      limit: 255
    t.string   "category",                 limit: 255
    t.integer  "points_register",          limit: 4
    t.integer  "points_transport",         limit: 4
    t.string   "about_photo_file_name",    limit: 255
    t.string   "about_photo_content_type", limit: 255
    t.integer  "about_photo_file_size",    limit: 8
    t.datetime "about_photo_updated_at"
    t.text     "replies_register",         limit: 65535
    t.text     "replies_rules",            limit: 65535
    t.datetime "ts_rules_started"
  end

end
