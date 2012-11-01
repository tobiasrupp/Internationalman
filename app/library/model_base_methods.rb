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
    search_string = SearchString.new(self).create
  end  
  
end
