class Post < ActiveRecord::Base
  attr_accessible :author, :country, :language, :latitude, :longitude, :short_title, :text, :title, :url_title, :publication_state, :allow_comments, :image_1, :image_1_options, :image_2, :image_2_options, :text_2, :ctry, :lat, :lon, :gmaps, :address
  attr_accessible :categories, :category_ids
  has_and_belongs_to_many :categories, :join_table => 'post_categories', :order => 'display_section ASC, display_sequence ASC'
  scope :published_posts, where("publication_state = 'Published'")
  scope :unpublished_posts, where("publication_state = 'Unpublished'")
  has_attached_file :image_1, :styles => { :medium => "320x320>", :small => "160x160>", :thumb => "100x100>" }, :convert_options => { :medium => "-quality 90", :small => "-quality 90", :thumb => "-quality 90"},
    :storage => :s3,
    :path => "posts/:attachment/:id/:style.:extension",
    :s3_credentials => "#{Rails.root}/config/aws.yml"

  has_attached_file :image_2, :styles => { :medium => "320x320>", :small => "160x160>", :thumb => "100x100>" }, :convert_options => { :medium => "-quality 90", :small => "-quality 90", :thumb => "-quality 90"},
    :storage => :s3,
    :path => "posts/:attachment/:id/:style.:extension",
    :s3_credentials => "#{Rails.root}/config/aws.yml"

  validates_attachment :image_1, :content_type => { :content_type => /image/ }, :size => { :in => 1..300.kilobytes }
  validates_attachment :image_2, :content_type => { :content_type => /image/ }, :size => { :in => 1..300.kilobytes }

  validates :title, :presence => true, :length => {:minimum => 1, :maximum => 254}
  validates :short_title, :presence => true, :length => {:minimum => 1, :maximum => 25}
  validates :url_title, :presence => true, :length => {:minimum => 1, :maximum => 100}, :uniqueness => { :case_sensitive => false }, :format => { :with => /\A[a-z\d-]+\z/, 
    :message => "Use only lowercase letters, dashes or numbers." }
  validates :language, :presence => true, :length => {:minimum => 2, :maximum => 40}
  validates :publication_state, :presence => true
  validates :categories, :presence => true

  translates :title, :short_title, :url_title, :ctry, :language, :text, :text_2, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale
  end

  acts_as_gmappable :lat => 'lat', :lng => 'lon', :address => "address", :validation => false, :msg => ""
  include PgSearch
  multisearchable :against => [:search_string],
                  :if => lambda { |record| record.publication_state == "Published" }
  
  def search_string
    original_locale = I18n.locale
    separator = ', '
    I18n.locale = :de
    search_content = 'Blog, Blogeintrag, Posts'
    search_content = search_content + separator + self.title unless self.title.nil? or self.title.blank?
    search_content = search_content + separator + self.short_title unless self.short_title.nil? or self.short_title.blank?
    search_content = search_content + separator + self.url_title unless self.url_title.nil? or self.url_title.blank?
    search_content = search_content + separator + self.text unless self.text.nil? or self.text.blank?
    search_content = search_content + separator + self.text_2 unless self.text_2.nil? or self.text_2.blank?
    search_content = search_content + separator + self.author unless self.author.nil? or self.author.blank?
    search_content = search_content + separator + I18n.l(self.created_at, :format => '%e. %B %Y') unless self.created_at.nil? or self.created_at.blank? 
    search_content = search_content + separator + self.ctry unless self.ctry.nil? or self.ctry.blank?
    search_content = search_content + separator + self.address unless self.address.nil? or self.address.blank?
    search_content = search_content + separator + self.category_list unless self.category_list.nil? or self.category_list.blank?
    I18n.locale = :en
    search_content = search_content + separator + self.title or self.title.blank?
    search_content = search_content + separator + self.short_title unless self.short_title.nil? or self.short_title.blank?
    search_content = search_content + separator + self.url_title unless self.url_title.nil? or self.url_title.blank?
    search_content = search_content + separator + self.text unless self.text.nil? or self.text.blank?
    search_content = search_content + separator + self.text_2 unless self.text_2.nil? or self.text_2.blank?
    search_content = search_content + separator + self.author unless self.author.nil? or self.author.blank?
    search_content = search_content + separator + I18n.l(self.created_at, :format => '%e %B %Y') unless self.created_at.nil? or self.created_at.blank?
    search_content = search_content + separator + self.ctry unless self.ctry.nil? or self.ctry.blank?
    search_content = search_content + separator + self.address unless self.address.nil? or self.address.blank?
    search_content = search_content + separator + self.category_list unless self.category_list.nil? or self.category_list.blank?
    I18n.locale = original_locale
    return search_content
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
   "picture" => "/assets/text_b_w.png",
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
