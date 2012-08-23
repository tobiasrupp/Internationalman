class Video < ActiveRecord::Base
  attr_accessible :author, :broadcast_date, :broadcaster, :country, :duration, :filename, :language, :latitude, :longitude, :short_title, :source_url, :title, :url_title, :web_page, :embed_code
  attr_accessible :categories, :category_ids
  has_and_belongs_to_many :categories, :join_table => 'video_categories', :order => 'display_section ASC, display_sequence ASC'
end
