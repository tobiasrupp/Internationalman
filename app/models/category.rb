class Category < ActiveRecord::Base
  attr_accessible :name, :display_sequence, :display_section, :url_name
  attr_accessible :article_ids, :articles
  attr_accessible :radio_track_ids, :radio_tracks
  has_and_belongs_to_many :articles, :join_table => 'article_categories', :order => "published_date DESC"
  has_and_belongs_to_many :radio_tracks, :join_table => 'radio_track_categories', :order => "broadcast_date DESC"
end
