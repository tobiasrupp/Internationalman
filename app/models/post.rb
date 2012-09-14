class Post < ActiveRecord::Base
  attr_accessible :author, :country, :language, :latitude, :longitude, :short_title, :text, :title, :url_title, :publication_state, :allow_comments, :image_1, :image_1_options, :image_2, :image_2_options, :text_2, :ctry 
  attr_accessible :categories, :category_ids
  has_and_belongs_to_many :categories, :join_table => 'post_categories', :order => 'display_section ASC, display_sequence ASC'
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
  validates :short_title, :presence => true, :length => {:minimum => 1, :maximum => 35}
  validates :url_title, :presence => true, :length => {:minimum => 1, :maximum => 100}, :uniqueness => { :case_sensitive => false }, :format => { :with => /\A[a-z\d-]+\z/, 
    :message => "Use only lowercase letters, dashes or numbers." }
  validates :language, :presence => true, :length => {:minimum => 2, :maximum => 40}
  validates :publication_state, :presence => true
  validates :categories, :presence => true

  translates :title, :short_title, :url_title, :ctry, :language, :text, :text_2, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale
  end
end
