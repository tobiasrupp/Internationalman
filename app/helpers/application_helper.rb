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
end
