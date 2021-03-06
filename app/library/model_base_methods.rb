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
    case self.class.name
    when 'Article'
      search_string = ArticleSearchString.new(self).create
    when 'Post'
      search_string = PostSearchString.new(self).create
    else # video and radio track
      search_string = VideoAndRadioTrackSearchString.new(self).create
    end
  end  

  def host
    if Rails.env.production?
      host = 'http://www.international-man.net'
    else
      host = 'http://localhost:3001'
    end
  end

  def url(corporate_article = false)
    return url = self.host + self.path unless corporate_article == true
    # corporate article
    return url = self.host + self.path(corporate_article)
  end 
end
