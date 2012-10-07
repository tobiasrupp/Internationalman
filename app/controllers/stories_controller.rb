class StoriesController < ApplicationController

  before_filter :set_status_message, :except => []

  def search
    if params[:query].blank?
      # flash.now[:error] = I18n.t(:enter_keywords) 
      return
    end
    if @hit_list = Article.text_search(params[:query])
      @no_of_hits = @hit_list.size
    else
      flash.now[:notice] = I18n.t(:no_documents_found)  
    end
    render(:layout => 'pages')
  end

  def rebuild_pg_search_documents
    Article.rebuild_pg_search_documents
    flash.now[:notice] = "Index rebuilt."  
    redirect_to search_path
  end

  def get_facebook_items_to_refresh
    if !params[:get_all] and !params[:days]
      return
    end
    starting_locale = I18n.locale

    all_urls = []
    I18n.locale = 'de'
    logger.debug "*** Locale set to '#{I18n.locale}'"
    all_urls = get_stories_to_refresh(params[:days])
    all_urls = all_urls + get_radio_tracks_to_refresh(params[:days])
    all_urls = all_urls + get_videos_to_refresh(params[:days])
    all_urls = all_urls + get_corporate_articles_to_refresh(params[:days])
    all_urls = all_urls + get_posts_to_refresh(params[:days])
    I18n.locale = 'en'
    logger.debug "*** Locale set to '#{I18n.locale}'"
    all_urls = all_urls + get_stories_to_refresh(params[:days])
    all_urls = all_urls + get_radio_tracks_to_refresh(params[:days])
    all_urls = all_urls + get_videos_to_refresh(params[:days])
    all_urls = all_urls + get_corporate_articles_to_refresh(params[:days])
    all_urls = all_urls + get_posts_to_refresh(params[:days])
    I18n.locale = starting_locale
    logger.debug "*** Locale set to '#{I18n.locale}'"
    @log = all_urls
    render(:layout => false)
  end
    
  def refresh_facebook_data_remote
    if !params[:refresh_all] and !params[:days] and !params[:url]
      return
    end

    @records_updated = 0
    @log = ""
    error = false
    error_occurred = false
    if params[:url]
      url = params[:url]
      response = RestClient.get('http://developers.facebook.com/tools/debug/og/object', :params => {:q => url })
      error = get_response_code_message(response.code, url)
    else
      items = []
      items = RestClient.get('http://www.international-man.net/de/get_facebook_items_to_refresh', :params => {:days => params[:days], :get_all => params[:refresh_all]})
      items.gsub!(/[\[\]]/,'')
      urls = items.split(', ')
      urls.each do |url|
        url.gsub!(/\A"|"\Z/, '')
        response = RestClient.get('http://developers.facebook.com/tools/debug/og/object', :params => {:q => url })
        error_occurred = get_response_code_message(response.code, url)
        if error_occurred == true
          error = true
        end
      end
    end
    if error == true
      flash.now[:error] = "Completed with errors."
    else
      flash.now[:notice] = "Completed successfully. Records updated: #{@records_updated}"
    end
    render(:layout => 'pages')
  end

  def show_stories
    # route /stories
    
    # add_locale_to_url

  	# get current story
    current_article = Article.find(:first,
                            :include => :categories,
                            :order => "published_date DESC")
    if current_article.nil?
      flash.now[:notice] = "Keine Stories gefunden."
      return
    end

    # get stories of the same category
    current_category = current_article.categories.first
    if current_category.nil?
    	flash.now[:error] = "Keine Stories mit Kategorien gefunden."
      return
    end 
    redirect_to stories_path + '/' + current_category.url_name + '/' + current_article.url_title
  end

  def show_stories_by_category

  	# route /stories/category

  	if !params[:category]
  		return
  	end 
  	
  	# get categories with stories (non-corporate)
    story_categories = Category.find(:all,              
                          :include => :articles,
                          :conditions => "name <> 'Corporate'",
                          :order => "display_section ASC, display_sequence ASC")
    
    @story_categories = []
    for category in story_categories
      if !category.articles.empty?
        @story_categories<<category
      end
    end
    if @story_categories.count == 0
      flash.now[:notice] = "Keine Stories mit Kategorien gefunden."
      return
    end

  	# get all stories of requested category sorted by published_date
  	current_category = Category.find_by_url_name(params[:category])

  	if !current_category.nil?
      @stories = current_category.articles
      @selected_category = current_category
      if params[:article_title]
      	@stories.each do |story|
      		if story.url_title == params[:article_title]
      			@selected_article = story
            @show_fb_like_button = true
      		end	
      	end
        if @selected_article.nil?
          # requested story unknown
          flash.now[:error] = "Story '#{params[:article_title]}' wurde nicht gefunden."
        end
      else	
      	current_article = @stories[0]
        redirect_to  stories_path + '/' + current_category.url_name + '/' + current_article.url_title
        return
    	end
    else  
    	# category unknown
    	flash.now[:error] = "Kategorie '#{params[:category]}' wurde nicht gefunden."
    end
    if long_titles?(@stories) 
      @content_section_column_width = 4
    else
      @content_section_column_width = 5
    end
  	render :action => "show_stories"
  end

  def feed
    @title = t(:alexander_buehler) + " - Journalist"
    @articles = Article.find(:all,
                  :include => :categories,
                  :order => "published_date DESC")
    @updated = @articles.first.published_date unless @articles.empty?
    @radio_tracks = RadioTrack.find(:all,
                  :include => :categories,
                  :order => "broadcast_date DESC")
    updated = @radio_tracks.first.broadcast_date unless @radio_tracks.empty?
    if updated > @updated
      @updated = updated
    end
    @videos = Video.find(:all,
                  :include => :categories,
                  :order => "broadcast_date DESC")
    updated = @videos.first.broadcast_date unless @videos.empty?
    if updated > @updated
      @updated = updated
    end
    @posts = Post.find(:all,
                :include => :categories,
                :conditions => "publication_state = 'Published'",
                :order => "created_at DESC")
    updated = @posts.first.created_at unless @posts.empty?
    if updated > @updated
      @updated = updated
    end
    respond_to do |format|
      format.atom
    end
  end

  private

  def get_stories_to_refresh(no_of_days)
    if no_of_days
      no_of_days = no_of_days.to_i
    else
      no_of_days = 0
    end
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
      url = stories_url + '/' + category.url_name + '/' + article.url_title
      urls << url
    end
    return urls
  end

  def get_radio_tracks_to_refresh(no_of_days)
    if no_of_days
      no_of_days = no_of_days.to_i
    else
      no_of_days = 0
    end
    if no_of_days >= 1
      radio_tracks = RadioTrack.find(:all,
            :conditions => ['updated_at >= ?', Time.now - no_of_days.day],
            :order => "broadcast_date DESC")
    else
      radio_tracks = RadioTrack.find(:all,
            :order => "broadcast_date DESC")
    end 
    urls = []
    radio_tracks.each do |track|
      url = radio_url + '/' + track.url_title
      urls << url
    end
    return urls
  end

  def get_videos_to_refresh(no_of_days)
    if no_of_days
      no_of_days = no_of_days.to_i
    else
      no_of_days = 0
    end
    if no_of_days >= 1
      videos = Video.find(:all,
            :conditions => ['updated_at >= ?', Time.now - no_of_days.day],
            :order => "broadcast_date DESC")
    else
      videos = Video.find(:all,
            :order => "broadcast_date DESC")
    end 
    urls = []
    videos.each do |video|
      url = tv_url + '/' + video.url_title
      urls << url
    end
    return urls
  end

  def get_corporate_articles_to_refresh(no_of_days)
    if no_of_days
      no_of_days = no_of_days.to_i
    else
      no_of_days = 0
    end
    if no_of_days >= 1
      category = Category.find_by_name('Corporate')
      articles = category.articles.find(:all,
            :conditions => ['updated_at >= ?', Time.now - no_of_days.day],
            :order => "published_date DESC")
    else
      category = Category.find_by_name('Corporate')
      articles = category.articles.find(:all,
            :order => "published_date DESC")
    end 
    urls = []
    articles.each do |article|
      url = corporate_url + '/' + article.url_title
      urls << url
    end
    return urls
  end

  def get_posts_to_refresh(no_of_days)
    error = false
    if no_of_days
      no_of_days = no_of_days.to_i
    else
      no_of_days = 0
    end
    if no_of_days >= 1
      posts = Post.find(:all,
            :conditions => ["updated_at >= ? AND publication_state = 'Published'", Time.now - no_of_days.day],
            :order => "created_at DESC")
    else
      posts = Post.find(:all,
            :conditions => ["publication_state = 'Published'"],
            :order => "created_at DESC")
    end 
    urls = []
    posts.each do |post|
      url = blog_url + '/' + post.url_title
      urls << url
    end
    return urls
  end

  def get_response_code_message(code, url)
    case code
      when 200...207
        logger.debug "*** Success #{response.code} (#{url})."
        @log = @log + "Success #{response.code} (#{url})" + "<br>"
        @records_updated = @records_updated + 1
      when 404
        logger.debug "*** ERROR #{response.code} (#{url})."
        @log = @log + "ERROR #{response.code} (#{url})" + "<br>"
        error = true
      when 500...600
        logger.debug "*** ERROR #{response.code} (#{url})."
        @log = @log + "ERROR #{response.code} (#{url})" + "<br>"
        error = true
      else
        logger.debug "*** ERROR #{response.code} (#{url})."
        @log = @log + "ERROR #{response.code} (#{url})" + "<br>"
        error = true
    end
  end 
end
