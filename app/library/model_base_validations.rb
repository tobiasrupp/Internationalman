module ModelBaseValidations
	def self.included(base)
		if base.kind_of?(Class)
			base.validates :title, :presence => true, :length => {:minimum => 1, :maximum => 254}
		  base.validates :short_title, :presence => true, :length => {:minimum => 1, :maximum => 35}
		  base.validates :url_title, :presence => true, :length => {:minimum => 1, :maximum => 100}, :uniqueness => { :case_sensitive => false }, :format => { :with => /\A[a-z\d-]+\z/, 
		    :message => "Use only lowercase letters, dashes or numbers." }
		  base.validates :language, :presence => true, :length => {:minimum => 2, :maximum => 40}
		  base.validates :categories, :presence => true
		end
	end
end