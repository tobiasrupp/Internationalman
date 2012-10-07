class RadioTrack < ActiveRecord::Base
  attr_accessible :author, :broadcast_date, :broadcaster, :country, :duration, :ctry
  attr_accessible :filename, :language, :latitude, :longitude, :short_title
  attr_accessible :source_url, :title, :url_title, :web_page, :copyright_cleared, :lat, :lon, :gmaps, :address
  attr_accessible :categories, :category_ids
  has_and_belongs_to_many :categories, :join_table => 'radio_track_categories',
  	:order => 'display_section ASC, display_sequence ASC'

  validates :title, :presence => true, :length => {:minimum => 1, :maximum => 254}
  validates :short_title, :presence => true, :length => {:minimum => 1, :maximum => 35}
  validates :url_title, :presence => true, :length => {:minimum => 1, :maximum => 100}, :uniqueness => { :case_sensitive => false }, :format => { :with => /\A[a-z\d-]+\z/, 
    :message => "Use only lowercase letters, dashes or numbers." }
  validates :language, :presence => true, :length => {:minimum => 2, :maximum => 40}
  validates :source_url, :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix, :message => "Use a URL starting with http:// or https:// " }, :allow_blank => true
  validates :web_page, :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix, :message => "Use a URL starting with http:// or https:// " }, :allow_blank => true
  validates :broadcast_date, :presence => true
  # validates :categories, :presence => true

	translates :title, :short_title, :url_title, :ctry, :language, :web_page, :source_url, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale
  end

  acts_as_gmappable :lat => 'lat', :lng => 'lon', :address => "address", :validation => false, :msg => ""
  include PgSearch
  multisearchable :against => [
    # :title,
    # :short_title,
    # :url_title,
    # :author,
    # :broadcast_date,
    # :ctry,
    # :broadcaster,
    # :address,
    # :category_list
   :search_string
    ]
  
  def search_string
    original_locale = I18n.locale
    separator = ', '
    I18n.locale = :de
    search_content = 'Radio, Audio, mp3'
       search_content = search_content + separator + self.title unless self.title.nil? or self.title.blank?
    search_content = search_content + separator + self.short_title unless self.short_title.nil? or self.short_title.blank?
    search_content = search_content + separator + self.url_title unless self.url_title.nil? or self.url_title.blank?
    search_content = search_content + separator + self.author unless self.author.nil? or self.author.blank?
    search_content = search_content + separator + I18n.l(self.broadcast_date, :format => '%e. %B %Y') unless self.broadcast_date.nil? or self.broadcast_date.blank? 
    search_content = search_content + separator + self.broadcaster unless self.broadcaster.nil? or self.broadcaster.blank?
    search_content = search_content + separator + self.ctry unless self.ctry.nil? or self.ctry.blank?
    search_content = search_content + separator + self.address unless self.address.nil? or self.address.blank?
    search_content = search_content + separator + self.category_list unless self.category_list.nil? or self.category_list.blank?
    I18n.locale = :en
    search_content = search_content + separator + self.title unless self.title.nil? or self.title.blank?
    search_content = search_content + separator + self.short_title unless self.short_title.nil? or self.short_title.blank?
    search_content = search_content + separator + self.url_title unless self.url_title.nil? or self.url_title.blank?
    search_content = search_content + separator + self.author unless self.author.nil? or self.author.blank?
    search_content = search_content + separator + I18n.l(self.broadcast_date, :format => '%e %B %Y') unless self.broadcast_date.nil?  or self.broadcast_date.blank?
    search_content = search_content + separator + self.broadcaster unless self.broadcaster.nil? or self.broadcaster.blank?
    search_content = search_content + separator + self.ctry unless self.ctry.nil? or self.ctry.blank?
    search_content = search_content + separator + self.address unless self.address.nil? or self.address.blank?
    search_content = search_content + separator + self.category_list unless self.category_list.nil? or self.category_list.blank?
    I18n.locale = original_locale
  end  
  
  def category_list
    category_list = ''
    self.categories.each do |category|
      if category_list == ''
        category_list = category.name
      else
        category_list = category_list + ', ' + category.name
      end
    end
    return category_list
  end

  def self.text_search(query)
    if query.present?
      PgSearch.multisearch(query)
    # else
    #   scoped
    end
  end

  def gmaps4rails_marker_picture
  {
   "picture" => "/assets/audio_b_w.png",
   "width" => 32,
   "height" => 37,
   # "marker_anchor" => [ 5, 10],
   "shadow_picture" => "http://maps.google.com/mapfiles/shadow50.png" ,
   "shadow_width" => "37",
   "shadow_height" => "34",
   "shadow_anchor" => [10, 34],
  }
  end
end
