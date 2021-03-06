class Post < ActiveRecord::Base
  include ModelBaseMethods
  include ModelBaseValidations
  attr_accessible :author, :country, :language, :latitude, :longitude, :short_title, :text, :title, :url_title, :publication_state, :allow_comments, :image_1, :image_1_options, :image_2, :image_2_options, :text_2, :ctry, :lat, :lon, :gmaps, :address
  attr_accessible :categories, :category_ids
  has_and_belongs_to_many :categories, :join_table => 'post_categories', :order => 'display_section ASC, display_sequence ASC'
  scope :published_posts, where("publication_state = 'Published'")
  scope :unpublished_posts, where("publication_state = 'Unpublished'")
  

  column_names = []
  column_names << :image_1
  column_names << :image_2
  styles = { :medium => "320x320>", :small => "160x160>", :thumb => "100x100>" }
  convert_options = { :medium => "-quality 90", :small => "-quality 90", :thumb => "-quality 90"}
  column_names.each do |column_name|
    has_attached_file column_name, :styles => styles, :convert_options => convert_options,
      :storage => :s3,
      :path => "posts/:attachment/:id/:style.:extension",
      :s3_credentials => "#{Rails.root}/config/aws.yml"
  end

  validates_attachment :image_1, :content_type => { :content_type => /image/ }, :size => { :in => 1..300.kilobytes }
  validates_attachment :image_2, :content_type => { :content_type => /image/ }, :size => { :in => 1..300.kilobytes }
  validates :publication_state, :presence => true
 
  translates :title, :short_title, :url_title, :ctry, :language, :text, :text_2, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale
  end

  acts_as_gmappable :lat => 'lat', :lng => 'lon', :address => "address", :validation => false, :msg => ""
  
  include PgSearch
  multisearchable :against => [:search_string],
                  :if => lambda { |record| record.publication_state == "Published" }

  def gmaps4rails_marker_picture
    map_icon('/assets/text_b_w.png')
  end

  def path
    path = "/#{I18n.locale}/blog/" + self.url_title
    return path
  end
end
