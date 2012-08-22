class RadioTrack < ActiveRecord::Base
  attr_accessible :author, :broadcast_date, :broadcaster, :country, :duration
  attr_accessible :filename, :language, :latitude, :longitude, :short_title
  attr_accessible :source_url, :title, :url_title, :web_page
  attr_accessible :categories, :category_ids
  has_and_belongs_to_many :categories, :join_table => 'radio_track_categories',
  	:order => 'display_section ASC, display_sequence ASC'

end
