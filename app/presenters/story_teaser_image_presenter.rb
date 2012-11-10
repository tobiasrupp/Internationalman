class StoryTeaserImagePresenter < BasePresenter
	presents :story
	attr_reader :image_size
	attr_accessor :format_for_map

  def build
  	return send("teaser_image_copyright_cleared_#{I18n.locale}") if story.copyright_cleared == true
  	return send("teaser_image_copyright_not_cleared_#{I18n.locale}") 
  end

private  
 	attr_writer :image_size

 	def image_size
		if @format_for_map == true
			@image_size = :thumb
		else
			@image_size = :medium
		end
		return @image_size
 	end

	def teaser_image_copyright_not_cleared_de
 		if story.teaser_image?
			s = image_without_link(:teaser_image)
		elsif story.teaser_image_en?
			s = image_without_link(:teaser_image_en)
		end
 	end

 	def teaser_image_copyright_not_cleared_en
 		if story.teaser_image_en?
			s = image_without_link(:teaser_image_en)
		elsif story.teaser_image?
			s = image_without_link(:teaser_image)
		end
 	end

 	def teaser_image_copyright_cleared_de
 		if story.teaser_image? and story.source_file?
			s = image_with_link_to_viewer(:teaser_image, :source_file)
		elsif story.teaser_image?
			s = image_without_link(:teaser_image)
		end
 	end

 	def teaser_image_copyright_cleared_en
 		if story.teaser_image_en? and story.source_file_en?
			s = image_with_link_to_viewer(:teaser_image_en, :source_file_en)
		elsif story.teaser_image? and story.source_file_en?
			s = image_with_link_to_viewer(:teaser_image, :source_file_en)
		elsif story.teaser_image? and story.source_file?
			s = image_with_link_to_viewer(:teaser_image, :source_file)
		# elsif story.teaser_image?
		# 	s = image_without_link(:teaser_image)
		end
 	end	

 	def image_with_link_to_viewer(image_field_name, source_file_field_name)
 		s = (link_to(get_image_tag(image_field_name), "https://docs.google.com/viewer?url=" + story.send(source_file_field_name).url, :target => '_blank')).html_safe
 	end

 	def get_image_tag(image_field_name)
 		s = image_tag(story.send(image_field_name).url(image_size), :alt => story.send(image_field_name).url(image_size), :title => t(:display_story_in_new_window), :class => "thumbnail")
 	end

 	def image_without_link(image_field_name)
 		s = (image_tag(story.send(image_field_name).url(image_size), :alt => story.send(image_field_name).url(image_size), :title => "", :class => "thumbnail")).html_safe
 	end

end