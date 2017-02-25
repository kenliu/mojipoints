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

ActiveRecord::Schema.define(version: 20170219154321) do

  create_table "recognitions", force: :cascade do |t|
    t.string   "teamid"
    t.string   "subject"
    t.string   "text"
    t.string   "ts"
    t.string   "slack_user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "bot_msg_ts"
    t.string   "channel"
    t.boolean  "vote_direction", default: true, null: false
  end

  create_table "slack_teams", force: :cascade do |t|
    t.string   "teamid"
    t.string   "oauth_access_token"
    t.string   "bot_userid"
    t.string   "bot_oauth_access_token"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "slack_users", force: :cascade do |t|
    t.string   "teamid"
    t.string   "slack_userid"
    t.string   "slack_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "votes", force: :cascade do |t|
    t.string   "teamid"
    t.integer  "recognition_id"
    t.integer  "slack_user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "emoji"
    t.boolean  "first_vote"
    t.integer  "point",          default: 1, null: false
  end

end
