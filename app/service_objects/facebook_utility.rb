class FacebookUtility
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

private
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

  def get_radio_tracks_to_refresh(no_of_days)
    if no_of_days >= 1
      radio_tracks = RadioTrack.find(:all,
            :conditions => ['updated_at >= ?', Time.now - no_of_days.day],
            :order => "broadcast_date DESC")
    else
      radio_tracks = RadioTrack.find(:all,
            :order => "broadcast_date DESC")
    end 
    return collect_urls(radio_tracks)
  end

  def get_videos_to_refresh(no_of_days)
    if no_of_days >= 1
      videos = Video.find(:all,
            :conditions => ['updated_at >= ?', Time.now - no_of_days.day],
            :order => "broadcast_date DESC")
    else
      videos = Video.find(:all,
            :order => "broadcast_date DESC")
    end 
    return collect_urls(videos)
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
