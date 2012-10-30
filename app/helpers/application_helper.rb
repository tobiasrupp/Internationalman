module ApplicationHelper
	
	# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = 'International Man'
    # base_title = "#{I18n.locale} - #{I18n.default_locale}"

    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def get_map_url(lon, lat)
    url = map_path + '?lat=' + lat + '&lon=' + lon
    return url
  end

  def get_cache_key(object)
    case object.class.name
      # when "Article"
      #   cache_key = "#{I18n.locale.to_s}-article-#{object.id}-#{object.updated_at.to_i}"
      # when "RadioTrack"
      #   cache_key = "#{I18n.locale.to_s}-radio_track-#{object.id}-#{object.updated_at.to_i}"
      # when "Video"
      #   cache_key = "#{I18n.locale.to_s}-video-#{object.id}-#{object.updated_at.to_i}"
      # when "Post"
      #   cache_key = "#{I18n.locale.to_s}-post-#{object.id}-#{object.updated_at.to_i}"
      when "Page"
        cache_key = "#{I18n.locale.to_s}-page-#{object.id}-#{object.updated_at.to_i}"
      # else
      #   cache_key = ""
    end
    return cache_key
  end  

  def category_list(categories)
    return false unless categories
    category_list = '' 
    categories.each do |category|
      if category_list == ''
        category_list = category.name
      else
        category_list = category_list + ', ' + category.name
      end
    end
    return category_list
  end
end
