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

ActiveRecord::Schema.define(version: 20170619191000) do

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "business_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "business_options", force: :cascade do |t|
    t.string   "option"
    t.integer  "business_id"
    t.integer  "category_option_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "business_pics", force: :cascade do |t|
    t.string   "image"
    t.integer  "business_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  create_table "business_sub_categories", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "sub_category_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "businesses", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "zip_code"
    t.string   "price_range"
    t.integer  "city_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "phone_number"
    t.integer  "user_id"
    t.string   "slug"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "icon_class"
    t.string   "slug"
  end

  create_table "category_options", force: :cascade do |t|
    t.string   "name"
    t.string   "options"
    t.boolean  "searchable"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "state_id"
    t.string   "slug"
  end

  create_table "conversations", force: :cascade do |t|
    t.string   "title"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "sender_trash"
    t.boolean  "recipient_trash"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "start_time"
    t.string   "price"
    t.integer  "business_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.text     "description"
    t.string   "slug"
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "following_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hours", force: :cascade do |t|
    t.string   "day"
    t.time     "opens_at"
    t.time     "closes_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "business_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "unread"
  end

  create_table "posts", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "review_stats", force: :cascade do |t|
    t.boolean  "useful"
    t.boolean  "funny"
    t.boolean  "cool"
    t.integer  "user_id"
    t.integer  "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "body"
    t.integer  "star_rating"
    t.integer  "user_id"
    t.integer  "business_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
  end

  create_table "topic_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string   "title"
    t.integer  "topic_category_id"
    t.integer  "city_id"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "slug"
  end

  create_table "user_events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "city_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "tagline"
    t.string   "gender"
    t.text     "i_love"
    t.text     "hometown"
    t.string   "website"
    t.string   "when_im_not_reviewing"
    t.string   "slug"
    t.string   "token"
    t.string   "avatar"
    t.boolean  "admin"
  end

end
