class Article < ActiveRecord::Base
  attr_accessible :article_type, :author, :ctry, :filename, :language
  attr_accessible :latitude, :longitude, :photos_by, :published_date, :published_in, :web_page
  attr_accessible :title, :url_title, :embed_code, :short_title, :viewer_url, :source_file, :copyright_cleared, :teaser_image_en, :source_file_en, :lon, :lat, :gmaps, :address
  attr_accessible :category_ids, :categories

  has_and_belongs_to_many :categories, :join_table => 'article_categories', :order => 'display_section ASC, display_sequence ASC'
  attr_accessible :teaser_image
  scope :corporate_articles, joins(:categories).where("categories.name = 'Corporate'")
  has_attached_file :teaser_image, :styles => { :medium => "430x304", :thumb => "100x100>" }, :convert_options => { :medium => "-quality 90", :thumb => "-quality 90"},
    :storage => :s3,
    :path => "articles/:attachment/:id/:style.:extension",
    :s3_credentials => "#{Rails.root}/config/aws.yml"
   
  has_attached_file :teaser_image_en, :styles => { :medium => "430x304", :thumb => "100x100>" }, :convert_options => { :medium => "-quality 90", :thumb => "-quality 90"},
    :storage => :s3,
    :path => "articles/:attachment/:id/:style.:extension",
    :s3_credentials => "#{Rails.root}/config/aws.yml"
      
  has_attached_file :source_file,
    :storage => :s3,
    :path => "articles/:attachment/:id/:style.:extension",
    :s3_credentials => "#{Rails.root}/config/aws.yml"

  has_attached_file :source_file_en,
    :storage => :s3,
    :path => "articles/:attachment/:id/:style.:extension",
    :s3_credentials => "#{Rails.root}/config/aws.yml"
      
  translates :title, :short_title, :url_title, :article_type, :ctry, :language, :web_page, :viewer_url, :embed_code, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale
  end

  validates_attachment :teaser_image, :content_type => { :content_type => /image/, 
    :message => "Invalid file type. Select an image." }, :size => { :in => 1..300.kilobytes }
  validates_attachment :teaser_image_en, :content_type => { :content_type => /image/, 
    :message => "Invalid file type. Select an image." }, :size => { :in => 1..300.kilobytes }
  validates_attachment :source_file, :content_type => { :content_type => /pdf/, 
    :message => "Invalid file type. Select a PDF." }, :size => { :in => 1..5000.kilobytes }
   validates_attachment :source_file_en, :content_type => { :content_type => /pdf/, 
    :message => "Invalid file type. Select a PDF." }, :size => { :in => 1..5000.kilobytes }
  validates :title, :presence => true, :length => {:minimum => 1, :maximum => 254}
  validates :short_title, :presence => true, :length => {:minimum => 1, :maximum => 35}
  validates :url_title, :presence => true, :length => {:minimum => 1, :maximum => 100}, :uniqueness => { :case_sensitive => false }, :format => { :with => /\A[a-z\d-]+\z/, 
    :message => "Use only lowercase letters, dashes or numbers." }
  validates :language, :presence => true, :length => {:minimum => 2, :maximum => 40}
  validates :web_page, :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix, :message => "Use a URL starting with http:// or https:// " }, :allow_blank => true

  validates :published_date, :presence => true
  validates :categories, :presence => true

  acts_as_gmappable :lat => 'lat', :lng => 'lon', :address => "address", :validation => false, :msg => ""

  include PgSearch
  multisearchable :against => [
    # :title,
    # :short_title,
    # :url_title,
    # :author,
    # :photos_by,
    # :published_date,
    # :ctry,
    # :published_in,
    # :article_type,
    # :address,
    # :category_list,
    :search_string
    ]
  
  def search_string
    original_locale = I18n.locale
    separator = ', '
    I18n.locale = :de
    search_content = 'Stories, Artikel, Article'
    search_content = search_content + separator + self.title unless self.title.nil? or self.title.blank?
    search_content = search_content + separator + self.short_title unless self.short_title.nil? or self.short_title.blank?
    search_content = search_content + separator + self.url_title unless self.url_title.nil? or self.url_title.blank?
    search_content = search_content + separator + self.author unless self.author.nil? or self.author.blank?
    search_content = search_content + separator + self.photos_by unless self.photos_by.nil? or self.photos_by.blank?
    search_content = search_content + separator + I18n.l(self.published_date, :format => '%e. %B %Y') unless self.published_date.nil? or self.published_date.blank?
    search_content = search_content + separator + self.published_in unless self.published_in.nil? or self.published_in.blank?
    search_content = search_content + separator + self.ctry unless self.ctry.nil? or self.ctry.blank?
    search_content = search_content + separator + self.article_type unless self.article_type.nil? or self.article_type.blank?
    search_content = search_content + separator + self.address unless self.address.nil? or self.address.blank?
    search_content = search_content + separator + self.category_list unless self.category_list.nil? or self.category_list.blank?
    I18n.locale = :en
    search_content = search_content + separator + self.title unless self.title.nil? or self.title.blank?
    search_content = search_content + separator + self.short_title unless self.short_title.nil? or self.short_title.blank?
    search_content = search_content + separator + self.url_title unless self.url_title.nil? or self.url_title.blank?
    search_content = search_content + separator + self.author unless self.author.nil? or self.author.blank?
    search_content = search_content + separator + self.photos_by unless self.photos_by.nil? or self.photos_by.blank?
    search_content = search_content + separator + I18n.l(self.published_date, :format => '%e %B %Y') unless self.published_date.nil? or self.published_date.blank? 
    search_content = search_content + separator + self.published_in unless self.published_in.nil? or self.published_in.blank?
    search_content = search_content + separator + self.ctry unless self.ctry.nil? or self.ctry.blank?
    search_content = search_content + separator + self.article_type unless self.article_type.nil? or self.article_type.blank?
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

  def self.rebuild_pg_search_documents
    find_each { |record| record.update_pg_search_document }
  end

  def self.text_search(query)
    if query.present?
      PgSearch.multisearch(query)
    end
  end

  def path
    category = self.categories[0]
    path = 'stories' + '/' + category.url_name + '/' + self.url_title
    return path
  end
  def gmaps4rails_marker_picture
  {
   "picture" => "/assets/administration_b_w.png",
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
