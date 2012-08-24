class Post < ActiveRecord::Base
  attr_accessible :author, :country, :language, :latitude, :longitude, :short_title, :text, :title, :url_title, :publication_state, :allow_comments 
  attr_accessible :categories, :category_ids
  has_and_belongs_to_many :categories, :join_table => 'post_categories', :order => 'display_section ASC, display_sequence ASC'
end
