class Article < ActiveRecord::Base
  attr_accessible :article_type, :author, :country, :filename, :language, :latitude, 
  	:longitude, :photos_by, :published_date, :published_in, :title, :url_title,
  	:embed_code, :short_title, :viewer_url
  attr_accessible :category_ids, :categories
  has_and_belongs_to_many :categories, :join_table => 'article_categories',
  	:order => 'display_section ASC, display_sequence ASC'
end
