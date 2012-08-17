class Category < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :article_ids, :articles
  has_and_belongs_to_many :articles, :join_table => 'article_categories'
end
