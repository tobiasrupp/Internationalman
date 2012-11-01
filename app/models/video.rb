class Video < ActiveRecord::Base
  include ModelBaseMethods
  attr_accessible :author, :broadcast_date, :broadcaster, :country, :duration, :filename, :language, :latitude, :longitude, :short_title, :source_url, :title, :url_title, :web_page, :embed_code, :camera_by, :ctry, :copyright_cleared, :lat, :lon, :gmaps, :address, :teaser_image, :video_width, :video_height, :video_aspect_ratio, :teaser_image_en
  attr_accessible :categories, :category_ids
  has_and_belongs_to_many :categories, :join_table => 'video_categories', :order => 'display_section ASC, display_sequence ASC'
  
  has_attached_file :teaser_image, :styles => { :sixteen_nine => "452x254!", :four_three => "452x337!", :thumb => "50x50!" }, :convert_options => { :sixteen_nine => "-quality 90", :four_three => "-quality 90", :thumb => "-quality 90"},
    :storage => :s3,
    :path => "videos/:attachment/:id/:style.:extension",
    :s3_credentials => "#{Rails.root}/config/aws.yml"
  has_attached_file :teaser_image_en, :styles => { :sixteen_nine => "452x254!", :four_three => "452x337!", :thumb => "50x50!" }, :convert_options => { :sixteen_nine => "-quality 90", :four_three => "-quality 90", :thumb => "-quality 90"},
    :storage => :s3,
    :path => "videos/:attachment/:id/:style.:extension",
    :s3_credentials => "#{Rails.root}/config/aws.yml"

  validates_attachment :teaser_image, :content_type => { :content_type => /image/, 
    :message => "Invalid file type. Select an image." }, :size => { :in => 1..300.kilobytes }
  validates_attachment :teaser_image_en, :content_type => { :content_type => /image/, 
    :message => "Invalid file type. Select an image." }, :size => { :in => 1..300.kilobytes }
  validates :title, :presence => true, :length => {:minimum => 1, :maximum => 254}
  validates :short_title, :presence => true, :length => {:minimum => 1, :maximum => 35}
  validates :url_title, :presence => true, :length => {:minimum => 1, :maximum => 100}, :uniqueness => { :case_sensitive => false }, :format => { :with => /\A[a-z\d-]+\z/, 
    :message => "Use only lowercase letters, dashes or numbers." }
  validates :language, :presence => true, :length => {:minimum => 2, :maximum => 40}
  validates :source_url, :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix, :message => "Use a URL starting with http:// or https:// " }, :allow_blank => true
  validates :web_page, :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix, :message => "Use a URL starting with http:// or https:// " }, :allow_blank => true
  validates :broadcast_date, :presence => true
  validates :categories, :presence => true

	translates :title, :short_title, :url_title, :ctry, :language, :embed_code, :web_page, :source_url, :video_width, :video_height, :video_aspect_ratio, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale
  end

  acts_as_gmappable :lat => 'lat', :lng => 'lon', :address => "address", :validation => false, :msg => ""
  
  include PgSearch
  multisearchable :against => [
    :search_string
    ]

  def gmaps4rails_marker_picture
    map_icon('/assets/video_b_w.png')
  end
end
