class StatusMessage < ActiveRecord::Base
  attr_accessible :text, :language

  validates :text, :presence => true, :length => {:minimum => 1, :maximum => 254}
  validates :language, :presence => true, :length => {:minimum => 2, :maximum => 40}
  translates :text, :language, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale
  end
end
