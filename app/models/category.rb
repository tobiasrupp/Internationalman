class Category < ActiveRecord::Base
  attr_accessible :name, :display_sequence, :display_section, :url_name
  attr_accessible :article_ids, :articles
  has_and_belongs_to_many :articles, :join_table => 'article_categories', :order => "published_date DESC"
end
