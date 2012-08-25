class Post < ActiveRecord::Base
  attr_accessible :author, :country, :language, :latitude, :longitude, :short_title, :text, :title, :url_title, :publication_state, :allow_comments, :image_1, :image_1_options, :image_2, :image_2_options, :text_2 
  attr_accessible :categories, :category_ids
  has_and_belongs_to_many :categories, :join_table => 'post_categories', :order => 'display_section ASC, display_sequence ASC'
  has_attached_file :image_1, :styles => { :medium => "320x320>", :small => "160x160>", :thumb => "100x100>" }
  has_attached_file :image_2, :styles => { :medium => "320x320>", :small => "160x160>", :thumb => "100x100>" }
  validates_attachment :image_1, :content_type => { :content_type => /image/ }, :size => { :in => 1..300.kilobytes }
  validates_attachment :image_2, :content_type => { :content_type => /image/ }, :size => { :in => 1..300.kilobytes }
end
