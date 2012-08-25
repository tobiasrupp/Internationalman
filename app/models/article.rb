class Article < ActiveRecord::Base
  attr_accessible :article_type, :author, :country, :filename, :language
  attr_accessible :latitude, :longitude, :photos_by, :published_date, :published_in
  attr_accessible :title, :url_title, :embed_code, :short_title, :viewer_url
  attr_accessible :category_ids, :categories
  has_and_belongs_to_many :categories, :join_table => 'article_categories',
  	:order => 'display_section ASC, display_sequence ASC'
  attr_accessible :teaser_image
  has_attached_file :teaser_image, :styles => { :medium => "500x320>", :thumb => "100x100>" }
  validates_attachment :teaser_image, :content_type => { :content_type => /image/ }, :size => { :in => 1..300.kilobytes }
  scope :corporate_articles, joins(:categories).where("categories.name = 'Corporate'")
end
