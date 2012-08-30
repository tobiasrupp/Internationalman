class Page < ActiveRecord::Base
  attr_accessible :body, :page_type, :title, :language

  validates :language, :presence => true, :length => {:minimum => 2, :maximum => 40}
  validates :page_type, :presence => true, :length => {:minimum => 2, :maximum => 40}, :uniqueness => { :case_sensitive => false }
  validates :title, :presence => true, :length => {:minimum => 2, :maximum => 80}, :uniqueness => { :case_sensitive => false }
  # translates :language, :title, :body, :fallbacks_for_empty_translations => true
  # class Translation
  #   attr_accessible :locale
  # end
end
