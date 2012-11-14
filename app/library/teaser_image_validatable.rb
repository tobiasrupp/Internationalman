module TeaserImageValidatable
	extend ActiveSupport::Concern

  included do
		validates_attachment :teaser_image, :content_type => { :content_type => /image/, :message => "Invalid file type. Select an image." }, :size => { :in => 1..300.kilobytes }
  	validates_attachment :teaser_image_en, :content_type => { :content_type => /image/, :message => "Invalid file type. Select an image." }, :size => { :in => 1..300.kilobytes }
  end
end