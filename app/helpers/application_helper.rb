module ApplicationHelper
	
	# Returns the full title on a per-page basis.
  def full_title(page_title)
    # base_title = 'International Man'
    base_title = "#{I18n.locale} - #{I18n.default_locale}"

    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  # def get_request_url_with_changed_locale(locale)            
  #   new_url = request.fullpath    
  #   new_locale_url = new_us_url = new_jp_url = new_url           
  #   if new_url == "/"          
  #     new_locale_url.sub!(/\//,locale)           
  #   elsif (new_url =~/\/en/) == 0        
  #     new_us_url.sub!(/\/en/,locale)        
  #   elsif (new_url =~/\/de/) == 0          
  #     new_jp_url.sub!(/\/de/,locale)       
  #   end     
  # end
end
