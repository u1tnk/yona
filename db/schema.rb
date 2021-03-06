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

ActiveRecord::Schema.define(version: 2) do

  create_table "article_read_logs", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "feed_id",    null: false
    t.integer  "article_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "article_read_logs", ["user_id", "feed_id", "article_id"], name: "index_article_read_logs_on_user_id_and_feed_id_and_article_id", unique: true, using: :btree

  create_table "articles", force: true do |t|
    t.integer  "feed_id",                       null: false
    t.string   "title",                         null: false
    t.string   "url",                           null: false
    t.text     "content",      limit: 16777215
    t.string   "author"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["feed_id", "published_at"], name: "index_articles_on_feed_id_and_published_at", using: :btree
  add_index "articles", ["url"], name: "index_articles_on_url", unique: true, using: :btree

  create_table "feed_tags", force: true do |t|
    t.integer  "feed_id",    null: false
    t.integer  "tag_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feed_tags", ["feed_id", "tag_id"], name: "index_feed_tags_on_feed_id_and_tag_id", unique: true, using: :btree

  create_table "feeds", force: true do |t|
    t.string   "url",                          null: false
    t.string   "title",                        null: false
    t.string   "html_url",                     null: false
    t.string   "kind",                         null: false
    t.string   "creator"
    t.string   "etag"
    t.datetime "last_modified_at"
    t.datetime "last_fetched_at"
    t.integer  "articles_count",   default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feeds", ["url"], name: "index_feeds_on_url", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "label",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["user_id", "label"], name: "index_tags_on_user_id_and_label", unique: true, using: :btree

  create_table "user_feeds", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "feed_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_feeds", ["user_id", "feed_id"], name: "index_user_feeds_on_user_id_and_feed_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "screen_name"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
