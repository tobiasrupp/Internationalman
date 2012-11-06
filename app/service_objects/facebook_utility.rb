class FacebookUtility
  attr_accessor :records_updated
  attr_accessor :log

	def initialize
    @original_locale = I18n.locale
  end

  def items_to_refresh(days)
  	@days = days.to_i
  	all_urls = []
    set_locale(:de)
    all_urls = get_urls(all_urls)
    set_locale(:en)
    all_urls = get_urls(all_urls)

    set_locale(@original_locale)
    return all_urls
  end

  def refresh_like_button_data(days = false, url = false)
    @log = ''
    @records_updated = 0
    ok = true
    if url.present?
      # refresh FB data for one item (page) by its url
      code = refresh_by_url(url)
      ok = handle_response_code(code, url)
    end  
    if days.present?
      # refresh FB data for multiple items changed within the given number of days
      urls = get_items_to_refresh_from_production(days)
      urls.each do |url|
        url.gsub!(/\A"|"\Z/, '') # remove quotation marks
        code = refresh_by_url(url)
        # debugger
        success = handle_response_code(code, url)
        if success == false
          ok = false
        end
      end
    end
    return ok
  end

private

  def refresh_by_url(url)
    if Rails.env.test?
      # mock get request in test environment
      code = 200
    else 
      response = RestClient.get('http://developers.facebook.com/tools/debug/og/object', :params => {:q => url })
      code = response.code
    end
    return code
  end  


  def handle_response_code(code, url)
    case code
      when 200...207
        Rails.logger.info "*** Success #{code} (#{url})."
        @log += "Success #{code} (#{url})" + "<br>"
        @records_updated += 1
        ok = true
      else
        Rails.logger.error "*** ERROR #{code} (#{url})."
        @log += "ERROR #{code} (#{url})" + "<br>"
        ok = false
    end
    return ok
  end 

  def get_items_to_refresh_from_production(days = false)
    items = []
    if Rails.env.test?
      # mock request in test environment, get data from local development environment
      request_root_url = "http://localhost:3001"
    else 
      request_root_url = "http://www.international-man.net"
    end
    items = RestClient.get("#{request_root_url}/de/get_facebook_items_to_refresh", :params => {:days => days})
    items.gsub!(/[\[\]]/,'') # remove brackets
    urls = items.split(', ')
    return urls
  end



	def set_locale(locale)
		I18n.locale = locale 
		Rails.logger.info "*** Locale set to '#{I18n.locale}'"
	end

  def get_urls(all_urls)
    all_urls += get_stories_to_refresh(@days)
    all_urls += get_items_to_refresh(@days, 'RadioTrack')
    all_urls += get_items_to_refresh(@days, 'Video')
    all_urls += get_corporate_articles_to_refresh(@days)
    all_urls += get_posts_to_refresh(@days)
  end

   def get_stories_to_refresh(no_of_days)
    if no_of_days >= 1
      articles = Article.find(:all,
            :include => :categories,
            :conditions => ['updated_at >= ?', Time.now - no_of_days.day],
            :order => "published_date DESC")
    else
      articles = Article.find(:all,
            :include => :categories,
            :order => "published_date DESC")
    end 
    urls = []
    articles.each do |article|
      category = article.categories[0]
      if category.name == 'Corporate'
        next
      end
      urls << article.url
    end
    return urls
  end


   def get_items_to_refresh(no_of_days, model_name)
   	model = model_name.constantize
    if no_of_days >= 1
      items = model.find(:all,
            :conditions => ['updated_at >= ?', Time.now - no_of_days.day],
            :order => "broadcast_date DESC")
    else
      items = model.find(:all,
            :order => "broadcast_date DESC")
    end 
    return collect_urls(items)
  end

  def get_corporate_articles_to_refresh(no_of_days)
  	category = Category.find_by_name('Corporate')
    if no_of_days >= 1
      articles = category.articles.find(:all,
            :conditions => ['updated_at >= ?', Time.now - no_of_days.day],
            :order => "published_date DESC")
    else
      articles = category.articles.find(:all,
            :order => "published_date DESC")
    end 
    return collect_urls(articles, true)
  end

  def get_posts_to_refresh(no_of_days)
    if no_of_days >= 1
      posts = Post.find(:all,
            :conditions => ["updated_at >= ? AND publication_state = 'Published'", Time.now - no_of_days.day],
            :order => "created_at DESC")
    else
      posts = Post.find(:all,
            :conditions => ["publication_state = 'Published'"],
            :order => "created_at DESC")
    end 
    return collect_urls(posts)
  end

  def collect_urls(items, corporate_articles = false)
  	urls = []
    items.each do |item|
      urls << item.url(corporate_articles)
    end
    return urls
  end
end
