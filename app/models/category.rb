class Category < ActiveRecord::Base
  attr_accessible :name, :display_sequence, :display_section, :url_name
  attr_accessible :article_ids, :articles
  attr_accessible :radio_track_ids, :radio_tracks
  attr_accessible :videos
  has_and_belongs_to_many :articles, :join_table => 'article_categories', :order => "published_date DESC"
  has_and_belongs_to_many :radio_tracks, :join_table => 'radio_track_categories', :order => "broadcast_date DESC"
  has_and_belongs_to_many :videos, :join_table => 'videos_categories', :order => "broadcast_date DESC"
  has_and_belongs_to_many :posts, :join_table => 'post_categories', :order => "updated_at DESC"
end
