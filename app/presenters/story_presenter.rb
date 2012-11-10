class StoryPresenter < BasePresenter
	presents :story
	attr_accessor :format_for_map
	attr_accessor :is_corporate
	attr_reader :image_size
	alias :super_title :title

 	def image_size
		if @format_for_map == true
			@image_size = :thumb
		else
			@image_size = :medium
		end
		return @image_size
 	end

	def title
		return '' if story.title.blank?		
		return map_title if @format_for_map == true
		s = super_title
	end

	def map_title
		if @is_corporate == true
			s = map_corp_story_title
		else
			s = map_story_title
		end
	end

  def published_in
		return '' if story.published_in.blank?
		if I18n.locale == :de
			return t(:published_in) + " &bdquo;#{ story.published_in }&rdquo;"
		else
			return t(:published_in) + " &ldquo;#{ story.published_in }&rdquo;"
		end	
  end

  def article_type(line_string)
		return line_string if story.article_type.blank?
		line_string = add_separator(line_string, ' ')
		line_string += "(#{story.article_type})"
	end
  
  def published_date(line_string)
		return line_string if story.published_date.blank?
		line_string = add_separator(line_string)
		line_string += "#{l story.published_date, :format => :long}"
  end

  def photos_by(line_string)
		return '' if story.photos_by.blank?
		line_string = add_separator(line_string)
		line_string += t(:photos) + ": #{story.photos_by}"
  end

  def source_file
		return '' unless story.copyright_cleared == true
		return send("source_file_#{I18n.locale}")
  end

  def teaser_image
  	return send("teaser_image_copyright_cleared_#{I18n.locale}") if story.copyright_cleared == true
  	return send("teaser_image_copyright_not_cleared_#{I18n.locale}") 
  end

private
 	attr_writer :image_size

 	def source_file_de
 		if story.source_file?
			s = button_display_story_in_viewer(story.source_file)
		elsif story.source_file_en?
			s = button_display_story_in_viewer(story.source_file_en)
		end
 	end

 	def source_file_en
 		if story.source_file_en?
			s = button_display_story_in_viewer(story.source_file_en)
		elsif story.source_file?
			s = button_display_story_in_viewer(story.source_file)
		end
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
		elsif story.teaser_image?
			s = image_without_link(:teaser_image)
		end
 	end	

 	def image_with_link_to_viewer(image_field_name, source_file_field_name)
 		s = (link_to(image_tag(story.send(image_field_name).url(self.image_size), :alt => story.send(image_field_name).url(self.image_size), :title => t(:display_story_in_new_window), :class => "thumbnail"), "https://docs.google.com/viewer?url=" + story.send(source_file_field_name).url, :target => '_blank')).html_safe
 	end

 	def image_without_link(image_field_name)
 		s = (image_tag(story.send(image_field_name).url(self.image_size), :alt => story.send(image_field_name).url(self.image_size), :title => "", :class => "thumbnail")).html_safe
 	end

 	def map_story_title
 		s = ('<span class="map_info_window_link">' + link_to(story.title + ' (Stories)', stories_path + '/' + story.categories[0].url_name + '/' + story.url_title) + '</span><br>').html_safe
 	end

 	def map_corp_story_title
 		s = ('<span class="map_info_window_link">' + link_to(story.title + ' (Corporate)', corporate_path + '/' + story.url_title) + '</span><br>').html_safe
 	end

 	def button_display_story_in_viewer(source_file_url)
 		s = ('<div class="button">' + link_to(t(:display_story_in_new_window), "https://docs.google.com/viewer?url=" + source_file_url.to_s, :target => '_blank', :class => "btn btn-small") + '</div>').html_safe
 	end
end