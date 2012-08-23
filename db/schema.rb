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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120823164151) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "article_categories", :id => false, :force => true do |t|
    t.integer "article_id"
    t.integer "category_id"
  end

  add_index "article_categories", ["article_id"], :name => "index_article_categories_on_article_id"
  add_index "article_categories", ["category_id"], :name => "index_article_categories_on_category_id"

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.string   "language"
    t.string   "country"
    t.string   "longitude"
    t.string   "latitude"
    t.string   "article_type"
    t.date     "published_date"
    t.string   "published_in"
    t.string   "filename"
    t.string   "author"
    t.string   "photos_by"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "url_title"
    t.text     "embed_code"
    t.string   "short_title"
    t.string   "viewer_url"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "display_sequence"
    t.integer  "display_section"
    t.string   "url_name"
  end

  create_table "pages", :force => true do |t|
    t.string   "page_type"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
  end

  create_table "radio_track_categories", :force => true do |t|
    t.integer "radio_track_id"
    t.integer "category_id"
  end

  add_index "radio_track_categories", ["category_id"], :name => "index_radio_track_categories_on_category_id"
  add_index "radio_track_categories", ["radio_track_id"], :name => "index_radio_track_categories_on_radio_track_id"

  create_table "radio_tracks", :force => true do |t|
    t.string   "title"
    t.string   "short_title"
    t.string   "url_title"
    t.string   "language"
    t.string   "country"
    t.string   "longitude"
    t.string   "latitude"
    t.integer  "duration"
    t.date     "broadcast_date"
    t.string   "broadcaster"
    t.string   "filename"
    t.string   "author"
    t.string   "source_url"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "web_page"
  end

  create_table "video_categories", :force => true do |t|
    t.integer "video_id"
    t.integer "category_id"
  end

  add_index "video_categories", ["category_id"], :name => "index_video_categories_on_category_id"
  add_index "video_categories", ["video_id"], :name => "index_video_categories_on_video_id"

  create_table "videos", :force => true do |t|
    t.string   "title"
    t.string   "short_title"
    t.string   "url_title"
    t.string   "language"
    t.string   "country"
    t.string   "longitude"
    t.string   "latitude"
    t.integer  "duration"
    t.date     "broadcast_date"
    t.string   "broadcaster"
    t.string   "filename"
    t.string   "author"
    t.string   "source_url"
    t.string   "web_page"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.text     "embed_code"
  end

end
