class Category < ActiveRecord::Base
  attr_accessible :name
  # attr_accessible :article_ids
  has_and_belongs_to_many :articles
end
