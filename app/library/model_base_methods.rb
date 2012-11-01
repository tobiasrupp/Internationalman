module ModelBaseMethods

  def category_list
    category_list = ''
    self.categories.each do |category|
      if category_list == ''
        category_list = category.name
      else
        category_list += ', ' + category.name
      end
    end
    return category_list
  end

  def map_icon(image_path)
  {
   "picture" => "#{image_path}",
   "width" => 32,
   "height" => 37,
   "shadow_picture" => "http://maps.google.com/mapfiles/shadow50.png",
   "shadow_width" => "37",
   "shadow_height" => "34",
   "shadow_anchor" => [10, 32],
  }
  end

  def search_string
  	# builds a search string with field values including German and English translations for full-text search
    original_locale = I18n.locale
    @separator = ', '
    I18n.locale = :de
    i = 0
    case self.class.name
   	 	when 'Video'
    		search_string = 'TV, Video, Fernsehen'
      when 'RadioTrack'
        search_string = 'Radio, Audio, mp3'
      when 'Post'
        search_string = 'Blog, Blogeintrag, Posts'
      when 'Article'
        search_string = 'Stories, Artikel, Article'
    end
    2.times do
    # loop 2 times, first in German then in English
      i += 1
      if i == 2
        I18n.locale = :en
      end
      search_string += check_and_add_value(self.title)
	    search_string += check_and_add_value(self.short_title)
	    search_string += check_and_add_value(self.url_title)
	    search_string += check_and_add_value(self.author)
      search_string += check_and_add_value(self.ctry)
      search_string += check_and_add_value(self.address)
      search_string += check_and_add_value(self.category_list)
      if self.class.name == 'Video' or self.class.name == 'RadioTrack'
  	    if i == 1 # German
  	    	search_string += check_and_add_value(I18n.l(self.broadcast_date, :format => '%e. %B %Y'))
  	  	elsif i == 2 # English
  	    	search_string += check_and_add_value(I18n.l(self.broadcast_date, :format => '%e %B %Y'))
  	    end
  	    search_string += check_and_add_value(self.broadcaster)
      elsif self.class.name == 'Post'
        if i == 1 # German
          search_string += check_and_add_value(I18n.l(self.created_at, :format => '%e. %B %Y'))
        elsif i == 2 # English
          search_string += check_and_add_value(I18n.l(self.created_at, :format => '%e %B %Y'))
        end
        search_string += check_and_add_value(self.text)
        search_string += check_and_add_value(self.text_2)
      elsif self.class.name == 'Article'
        if i == 1 # German
          search_string += check_and_add_value(I18n.l(self.published_date, :format => '%e. %B %Y'))
        elsif i == 2 # English
          search_string += check_and_add_value(I18n.l(self.published_date, :format => '%e %B %Y'))
        end
        search_string += check_and_add_value(self.published_in)
        search_string += check_and_add_value(self.photos_by)
        search_string += check_and_add_value(self.article_type)
      end 
  	end
  	I18n.locale = original_locale
		return search_string
  end  

private
  
  def check_and_add_value(value)
    if value.nil? or value.blank?
      return ''
    end  
    @separator + value 
  end
end
