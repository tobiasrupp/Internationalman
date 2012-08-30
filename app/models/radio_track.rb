class RadioTrack < ActiveRecord::Base
  attr_accessible :author, :broadcast_date, :broadcaster, :country, :duration, :ctry
  attr_accessible :filename, :language, :latitude, :longitude, :short_title
  attr_accessible :source_url, :title, :url_title, :web_page
  attr_accessible :categories, :category_ids
  has_and_belongs_to_many :categories, :join_table => 'radio_track_categories',
  	:order => 'display_section ASC, display_sequence ASC'

  validates :title, :presence => true, :length => {:minimum => 1, :maximum => 254}
  validates :short_title, :presence => true, :length => {:minimum => 1, :maximum => 100}
  validates :url_title, :presence => true, :length => {:minimum => 1, :maximum => 100}, :uniqueness => { :case_sensitive => false }, :format => { :with => /\A[a-z\d-]+\z/, 
    :message => "Use only lowercase letters, dashes or numbers." }
  validates :language, :presence => true, :length => {:minimum => 2, :maximum => 40}
  validates :source_url, :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix, :message => "Use a URL starting with http:// or https:// " }, :allow_blank => true
  validates :web_page, :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix, :message => "Use a URL starting with http:// or https:// " }, :allow_blank => true
  validates :broadcast_date, :presence => true
  # validates :categories, :presence => true

	translates :title, :short_title, :url_title, :ctry, :language, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale
  end
end
