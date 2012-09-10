class Article < ActiveRecord::Base
  attr_accessible :article_type, :author, :ctry, :filename, :language
  attr_accessible :latitude, :longitude, :photos_by, :published_date, :published_in, :web_page
  attr_accessible :title, :url_title, :embed_code, :short_title, :viewer_url, :source_file
  attr_accessible :category_ids, :categories

  has_and_belongs_to_many :categories, :join_table => 'article_categories', :order => 'display_section ASC, display_sequence ASC'
  attr_accessible :teaser_image
  scope :corporate_articles, joins(:categories).where("categories.name = 'Corporate'")
  has_attached_file :teaser_image, :styles => { :medium => "500x320>", :thumb => "100x100>" }, :convert_options => { :medium => "-quality 90", :thumb => "-quality 90"},
    :storage => :s3,
    :path => "articles/:attachment/:id/:style.:extension",
    :s3_credentials => "#{Rails.root}/config/aws.yml"
    
  has_attached_file :source_file,
    :storage => :s3,
    :path => "articles/:attachment/:id/:style.:extension",
    :s3_credentials => "#{Rails.root}/config/aws.yml"

  translates :title, :short_title, :url_title, :article_type, :ctry, :language, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale
  end

  validates_attachment :teaser_image, :content_type => { :content_type => /image/ }, :size => { :in => 1..300.kilobytes }
  validates_attachment :source_file, :content_type => { :content_type => /pdf/ }, :size => { :in => 1..5000.kilobytes }
  validates :title, :presence => true, :length => {:minimum => 1, :maximum => 254}
  validates :short_title, :presence => true, :length => {:minimum => 1, :maximum => 35}
  validates :url_title, :presence => true, :length => {:minimum => 1, :maximum => 100}, :uniqueness => { :case_sensitive => false }, :format => { :with => /\A[a-z\d-]+\z/, 
    :message => "Use only lowercase letters, dashes or numbers." }
  validates :language, :presence => true, :length => {:minimum => 2, :maximum => 40}
  validates :web_page, :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix, :message => "Use a URL starting with http:// or https:// " }, :allow_blank => true

  validates :published_date, :presence => true
  validates :categories, :presence => true
end
