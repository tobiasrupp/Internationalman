class RadioTrack < ActiveRecord::Base
  include ModelBaseMethods
  include ModelBaseValidations
  include ModelBaseDefinitions
  attr_accessible :author, :broadcast_date, :broadcaster, :country, :duration, :ctry
  attr_accessible :filename, :language, :latitude, :longitude, :short_title
  attr_accessible :source_url, :title, :url_title, :web_page, :copyright_cleared, :lat, :lon, :gmaps, :address
  attr_accessible :categories, :category_ids
  has_and_belongs_to_many :categories, :join_table => 'radio_track_categories',
  	:order => 'display_section ASC, display_sequence ASC'

  validates :source_url, :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix, :message => "Use a URL starting with http:// or https:// " }, :allow_blank => true
  validates :broadcast_date, :presence => true
  
	translates :title, :short_title, :url_title, :ctry, :language, :web_page, :source_url, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale
  end

  include PgSearch
  multisearchable :against => [
   :search_string
    ] 

  def gmaps4rails_marker_picture
    map_icon('/assets/audio_b_w.png')
  end

  def path
    path = "/#{I18n.locale}/radio/" + self.url_title
    return path
  end
end
