class StoryPresenter < BasePresenter
	presents :story
	attr_accessor :format_for_map
	attr_accessor :is_corporate
	attr_reader :image_size

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
		if @format_for_map == true
			if @is_corporate == true
				s = ('<span class="map_info_window_link">' + link_to(story.title + ' (Corporate)', corporate_path + '/' + story.url_title) + '</span><br>').html_safe
			else
				s = ('<span class="map_info_window_link">' + link_to(story.title + ' (Stories)', stories_path + '/' + story.categories[0].url_name + '/' + story.url_title) + '</span><br>').html_safe
			end
		else
			s = ('<h3>' + story.title + '</h3>').html_safe
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

private
 	attr_writer :image_size


end