class StoryPresenter < ModelBasePresenter
	presents :story
	attr_accessor :format_for_map
	attr_accessor :is_corporate

	alias :super_title :title

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
  	image_presenter = StoryTeaserImagePresenter.new(story, @template)
  	image_presenter.format_for_map = @format_for_map
  	return image_presenter.build
  end

private

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

 	def map_story_title
 		s = ('<span class="map_info_window_link">' + link_to(story.title + ' (Stories)', story.path) + '</span><br>').html_safe
 	end

 	def map_corp_story_title
 		s = ('<span class="map_info_window_link">' + link_to(story.title + ' (Corporate)', story.path(true)) + '</span><br>').html_safe
 	end

 	def button_display_story_in_viewer(source_file_url)
 		s = ('<div class="button">' + link_to(t(:display_story_in_new_window), "https://docs.google.com/viewer?url=" + source_file_url.to_s, :target => '_blank', :class => "btn btn-small") + '</div>').html_safe
 	end
end
