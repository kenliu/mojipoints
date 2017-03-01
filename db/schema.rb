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

ActiveRecord::Schema.define(version: 20170226042828) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "recognitions", force: :cascade do |t|
    t.string   "teamid"
    t.string   "subject",                       null: false
    t.string   "text"
    t.string   "ts",                            null: false
    t.integer  "slack_user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "bot_msg_ts"
    t.string   "channel",                       null: false
    t.boolean  "vote_direction", default: true, null: false
    t.index ["slack_user_id"], name: "index_recognitions_on_slack_user_id", using: :btree
    t.index ["subject"], name: "index_recognitions_on_subject", using: :btree
    t.index ["text"], name: "index_recognitions_on_text", using: :btree
  end

  create_table "slack_teams", force: :cascade do |t|
    t.string   "teamid",                 null: false
    t.string   "oauth_access_token",     null: false
    t.string   "bot_userid",             null: false
    t.string   "bot_oauth_access_token", null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "slack_users", force: :cascade do |t|
    t.string   "teamid"
    t.string   "slack_userid", null: false
    t.string   "slack_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "votes", force: :cascade do |t|
    t.string   "teamid"
    t.integer  "recognition_id",                null: false
    t.integer  "slack_user_id",                 null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "emoji"
    t.boolean  "first_vote",     default: true, null: false
    t.integer  "point",          default: 1,    null: false
    t.index ["recognition_id"], name: "index_votes_on_recognition_id", using: :btree
  end

  add_foreign_key "recognitions", "slack_users"
  add_foreign_key "votes", "recognitions"
end
