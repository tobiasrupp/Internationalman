class Article < ActiveRecord::Base
  include ModelBaseMethods
  include ModelBaseValidations
  include ModelBaseDefinitions
  include TeaserImageValidatable
  attr_accessible :article_type, :author, :ctry, :filename, :language
  attr_accessible :latitude, :longitude, :photos_by, :published_date, :published_in, :web_page
  attr_accessible :title, :url_title, :embed_code, :short_title, :viewer_url, :source_file, :copyright_cleared, :teaser_image_en, :source_file_en, :lon, :lat, :gmaps, :address
  attr_accessible :category_ids, :categories

  has_and_belongs_to_many :categories, :join_table => 'article_categories', :order => 'display_section ASC, display_sequence ASC'
  attr_accessible :teaser_image
  scope :corporate_articles, joins(:categories).where("categories.name = 'Corporate'")
  
  column_names = []
  column_names << :teaser_image
  column_names << :teaser_image_en
  column_names.each do |column_name|
    has_attached_file column_name, :styles => { :medium => "430x304", :thumb => "100x100>" }, :convert_options => { :medium => "-quality 90", :thumb => "-quality 90"},
      :storage => :s3,
      :path => "articles/:attachment/:id/:style.:extension",
      :s3_credentials => "#{Rails.root}/config/aws.yml"
  end

  column_names = []
  column_names << :source_file
  column_names << :source_file_en
  column_names.each do |column_name|
    has_attached_file column_name,
      :storage => :s3,
      :path => "articles/:attachment/:id/:style.:extension",
      :s3_credentials => "#{Rails.root}/config/aws.yml"
  end
      
  translates :title, :short_title, :url_title, :article_type, :ctry, :language, :web_page, :viewer_url, :embed_code, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale
  end

  validates_attachment :source_file, :content_type => { :content_type => /pdf/, 
    :message => "Invalid file type. Select a PDF." }, :size => { :in => 1..5000.kilobytes }
   validates_attachment :source_file_en, :content_type => { :content_type => /pdf/, 
    :message => "Invalid file type. Select a PDF." }, :size => { :in => 1..5000.kilobytes }
  
  validates :published_date, :presence => true
  
  include PgSearch
  multisearchable :against => [
    :search_string
    ]

  def self.text_search(query)
    if query.present?
      PgSearch.multisearch(query)
    # else
    #   scoped
    end
  end

  def self.rebuild_pg_search_documents
    find_each { |record| record.update_pg_search_document }
  end

  def path(corporate_article = false)
    if corporate_article == true
      path = "/#{I18n.locale}/corporate/" + self.url_title
    else
      category = self.categories[0]
      path = "/#{I18n.locale}/stories/" + category.url_name + '/' + self.url_title
    end
    return path
  end

  def gmaps4rails_marker_picture
    map_icon('/assets/administration_b_w.png')
  end
end
