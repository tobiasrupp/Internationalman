class Article < ActiveRecord::Base
  attr_accessible :article_type, :author, :country, :filename, :language, :latitude, :longitude, :photos_by, :published_date, :published_in, :title
  attr_accessible :category_ids, :categories
  has_and_belongs_to_many :categories
end
