# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_180_811_184_957) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "playlists", force: :cascade do |t|
    t.bigint "user_id"
    t.string "spotify_id"
    t.string "spotify_description"
    t.string "spotify_href"
    t.string "spotify_name"
    t.string "spotify_uri"
    t.string "spotify_snapshot_id"
    t.json "spotify_images"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_playlists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
  add_foreign_key "playlists", "users"
end
