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

ActiveRecord::Schema.define(:version => 20121009155718) do

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

  create_table "article_translations", :force => true do |t|
    t.integer  "article_id"
    t.string   "locale"
    t.string   "title"
    t.string   "short_title"
    t.string   "url_title"
    t.string   "article_type"
    t.string   "ctry"
    t.string   "language"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "web_page"
    t.string   "viewer_url"
    t.text     "embed_code"
  end

  add_index "article_translations", ["article_id"], :name => "index_article_translations_on_article_id"
  add_index "article_translations", ["locale"], :name => "index_article_translations_on_locale"

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.string   "language"
    t.string   "longitude"
    t.string   "latitude"
    t.string   "article_type"
    t.date     "published_date"
    t.string   "published_in"
    t.string   "author"
    t.string   "photos_by"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "url_title"
    t.text     "embed_code"
    t.string   "short_title"
    t.string   "viewer_url"
    t.string   "teaser_image_file_name"
    t.string   "teaser_image_content_type"
    t.integer  "teaser_image_file_size"
    t.datetime "teaser_image_updated_at"
    t.string   "country"
    t.string   "filename"
    t.string   "ctry"
    t.string   "web_page"
    t.string   "source_file_file_name"
    t.string   "source_file_content_type"
    t.integer  "source_file_file_size"
    t.datetime "source_file_updated_at"
    t.boolean  "copyright_cleared"
    t.string   "teaser_image_en_file_name"
    t.string   "teaser_image_en_content_type"
    t.integer  "teaser_image_en_file_size"
    t.datetime "teaser_image_en_updated_at"
    t.string   "source_file_en_file_name"
    t.string   "source_file_en_content_type"
    t.integer  "source_file_en_file_size"
    t.datetime "source_file_en_updated_at"
    t.float    "lat"
    t.float    "lon"
    t.boolean  "gmaps"
    t.string   "address"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "display_sequence"
    t.integer  "display_section"
    t.string   "url_name"
    t.string   "url_title"
    t.string   "language"
  end

  create_table "category_translations", :force => true do |t|
    t.integer  "category_id"
    t.string   "locale"
    t.string   "name"
    t.string   "url_name"
    t.string   "language"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "category_translations", ["category_id"], :name => "index_category_translations_on_category_id"
  add_index "category_translations", ["locale"], :name => "index_category_translations_on_locale"

  create_table "page_translations", :force => true do |t|
    t.integer  "page_id"
    t.string   "locale"
    t.string   "title"
    t.text     "body"
    t.string   "language"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "page_translations", ["locale"], :name => "index_page_translations_on_locale"
  add_index "page_translations", ["page_id"], :name => "index_page_translations_on_page_id"

  create_table "pages", :force => true do |t|
    t.string   "page_type"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
    t.string   "language"
  end

  create_table "pg_search_documents", :force => true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "post_categories", :force => true do |t|
    t.integer "post_id"
    t.integer "category_id"
  end

  add_index "post_categories", ["category_id"], :name => "index_post_categories_on_category_id"
  add_index "post_categories", ["post_id"], :name => "index_post_categories_on_post_id"

  create_table "post_translations", :force => true do |t|
    t.integer  "post_id"
    t.string   "locale"
    t.string   "title"
    t.string   "short_title"
    t.string   "url_title"
    t.string   "ctry"
    t.string   "language"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "text"
    t.text     "text_2"
  end

  add_index "post_translations", ["locale"], :name => "index_post_translations_on_locale"
  add_index "post_translations", ["post_id"], :name => "index_post_translations_on_post_id"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.string   "short_title"
    t.string   "url_title"
    t.string   "language"
    t.string   "author"
    t.text     "text"
    t.string   "country"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "publication_state"
    t.boolean  "allow_comments"
    t.string   "image_1_file_name"
    t.string   "image_1_content_type"
    t.integer  "image_1_file_size"
    t.datetime "image_1_updated_at"
    t.string   "image_1_options"
    t.string   "image_2_file_name"
    t.string   "image_2_content_type"
    t.integer  "image_2_file_size"
    t.datetime "image_2_updated_at"
    t.string   "image_2_options"
    t.text     "text_2"
    t.string   "ctry"
    t.float    "lat"
    t.float    "lon"
    t.boolean  "gmaps"
    t.string   "address"
  end

  create_table "radio_track_categories", :force => true do |t|
    t.integer "radio_track_id"
    t.integer "category_id"
  end

  add_index "radio_track_categories", ["category_id"], :name => "index_radio_track_categories_on_category_id"
  add_index "radio_track_categories", ["radio_track_id"], :name => "index_radio_track_categories_on_radio_track_id"

  create_table "radio_track_translations", :force => true do |t|
    t.integer  "radio_track_id"
    t.string   "locale"
    t.string   "title"
    t.string   "short_title"
    t.string   "url_title"
    t.string   "ctry"
    t.string   "language"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "web_page"
    t.string   "source_url"
  end

  add_index "radio_track_translations", ["locale"], :name => "index_radio_track_translations_on_locale"
  add_index "radio_track_translations", ["radio_track_id"], :name => "index_radio_track_translations_on_radio_track_id"

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
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "web_page"
    t.string   "ctry"
    t.boolean  "copyright_cleared"
    t.float    "lat"
    t.float    "lon"
    t.boolean  "gmaps"
    t.string   "address"
  end

  create_table "status_message_translations", :force => true do |t|
    t.integer  "status_message_id"
    t.string   "locale"
    t.string   "text"
    t.string   "language"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "status_message_translations", ["locale"], :name => "index_status_message_translations_on_locale"
  add_index "status_message_translations", ["status_message_id"], :name => "index_7294d366b6a9642970246bf3caa310a84f7ed68e"

  create_table "status_messages", :force => true do |t|
    t.string   "text"
    t.string   "language"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "tweet_id"
    t.string   "tweet_screen_name"
    t.datetime "tweet_created_at"
  end

  create_table "video_categories", :force => true do |t|
    t.integer "video_id"
    t.integer "category_id"
  end

  add_index "video_categories", ["category_id"], :name => "index_video_categories_on_category_id"
  add_index "video_categories", ["video_id"], :name => "index_video_categories_on_video_id"

  create_table "video_translations", :force => true do |t|
    t.integer  "video_id"
    t.string   "locale"
    t.string   "title"
    t.string   "short_title"
    t.string   "url_title"
    t.string   "ctry"
    t.string   "language"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.text     "embed_code"
    t.string   "web_page"
    t.string   "source_url"
    t.string   "video_width"
    t.string   "video_height"
    t.string   "video_aspect_ratio"
  end

  add_index "video_translations", ["locale"], :name => "index_video_translations_on_locale"
  add_index "video_translations", ["video_id"], :name => "index_video_translations_on_video_id"

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
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.text     "embed_code"
    t.string   "camera_by"
    t.string   "ctry"
    t.boolean  "copyright_cleared"
    t.float    "lat"
    t.float    "lon"
    t.boolean  "gmaps"
    t.string   "address"
    t.string   "video_width"
    t.string   "video_height"
    t.string   "video_aspect_ratio"
    t.string   "teaser_image_file_name"
    t.string   "teaser_image_content_type"
    t.integer  "teaser_image_file_size"
    t.datetime "teaser_image_updated_at"
    t.string   "teaser_image_en_file_name"
    t.string   "teaser_image_en_content_type"
    t.integer  "teaser_image_en_file_size"
    t.datetime "teaser_image_en_updated_at"
  end

end
