class StoriesController < ApplicationController

  before_filter :set_status_message, :except => [:refresh_facebook_data]

  def refresh_facebook_data
    if !params[:refresh_all] and !params[:days] and !params[:url]
      return
    end
    if params[:url]
      url = "developers.facebook.com/tools/debug/og/object?q=" + params[:url]
    else
      url = "developers.facebook.com/tools/debug/og/object?q=http://www.international-man.net/de/stories/tech/snowleopard-osx"
    end
    response = RestClient.get(url, :headers => {"User-Agent" => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:15.0) Gecko/20100101 Firefox/15.0.1'})
    # response = RestClient.get('developers.facebook.com/tools/debug/og/object?q=http://www.international-man.net/en/blog/pakunst')
    @log = response
    # error = false
    # @records_updated = 0
    # @log = ""
    # case I18n.locale
    #   when :de
    #     error = refresh_facebook_data_of_stories(params[:days])
    #     error = refresh_facebook_data_of_radio_tracks(params[:days])
    #     error = refresh_facebook_data_of_videos(params[:days])
    #     error = refresh_facebook_data_of_corporate_articles(params[:days])
    #     error = refresh_facebook_data_of_posts(params[:days])
    #     I18n.locale = 'en'
    #     logger.debug "*** Locale set to '#{I18n.locale}'"
    #     error = refresh_facebook_data_of_stories(params[:days])
    #     error = refresh_facebook_data_of_radio_tracks(params[:days])
    #     error = refresh_facebook_data_of_videos(params[:days])
    #     error = refresh_facebook_data_of_corporate_articles(params[:days])
    #     error = refresh_facebook_data_of_posts(params[:days])
    #     I18n.locale = 'de'
    #     logger.debug "*** Locale set to '#{I18n.locale}'"
    #   when :en
    #     error = refresh_facebook_data_of_stories(params[:days])
    #     error = refresh_facebook_data_of_radio_tracks(params[:days])
    #     error = refresh_facebook_data_of_videos(params[:days])
    #     error = refresh_facebook_data_of_corporate_articles(params[:days])
    #     error = refresh_facebook_data_of_posts(params[:days])
    #     I18n.locale = 'de'
    #     logger.debug "*** Locale set to '#{I18n.locale}'"
    #     error = refresh_facebook_data_of_stories(params[:days])
    #     error = refresh_facebook_data_of_radio_tracks(params[:days])
    #     error = refresh_facebook_data_of_videos(params[:days])
    #     error = refresh_facebook_data_of_corporate_articles(params[:days])
    #     error = refresh_facebook_data_of_posts(params[:days])
    #     I18n.locale = 'en'
    #     logger.debug "*** Locale set to '#{I18n.locale}'"
    # end
    # if error == true
    #   flash.now[:error] = "Completed with errors."
    # else
    #   flash.now[:notice] = "Completed successfully. Records updated: #{@records_updated}"
    # end
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

  def refresh_facebook_data_of_stories(no_of_days)
    error = false
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
    articles.each do |article|
      category = article.categories[0]
      if category.name == 'Corporate'
        next
      end
      url = 'http://developers.facebook.com/tools/debug/og/object?q=' + stories_url + '/' + category.url_name + '/' + article.url_title
      response = HTTParty.get(url, :headers => {"User-Agent" => 'Mozilla/5.0 (iPad; U; CPU OS 3_2_1 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Mobile/7B405'})
      # puts response.inspect
      error = get_response_code_message(response.code, url)
    end
    return error
  end

  def refresh_facebook_data_of_radio_tracks(no_of_days)
    error = false
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
    radio_tracks.each do |track|
      url = 'http://developers.facebook.com/tools/debug/og/object?q=' + radio_url + '/' + track.url_title
      response = HTTParty.get(url, :headers => {"User-Agent" => 'Mozilla/5.0 (iPad; U; CPU OS 3_2_1 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Mobile/7B405'})

      error = get_response_code_message(response.code, url)
    end
    return error
  end

  def refresh_facebook_data_of_videos(no_of_days)
    error = false
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
    videos.each do |video|
      url = 'http://developers.facebook.com/tools/debug/og/object?q=' + tv_url + '/' + video.url_title
      response = HTTParty.get(url, :headers => {"User-Agent" => 'Mozilla/5.0 (iPad; U; CPU OS 3_2_1 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Mobile/7B405'})
      error = get_response_code_message(response.code, url)
    end
    return error
  end

  def refresh_facebook_data_of_corporate_articles(no_of_days)
    error = false
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
    articles.each do |article|
      url = 'http://developers.facebook.com/tools/debug/og/object?q=' + corporate_url + '/' + article.url_title
      response = HTTParty.get(url, :headers => {"User-Agent" => 'Mozilla/5.0 (iPad; U; CPU OS 3_2_1 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Mobile/7B405'})

      error = get_response_code_message(response.code, url)
    end
    return error
  end

  def refresh_facebook_data_of_posts(no_of_days)
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
    posts.each do |post|
      url = 'http://developers.facebook.com/tools/debug/og/object?q=' + blog_url + '/' + post.url_title
      response = HTTParty.get(url, :headers => {"User-Agent" => 'Mozilla/5.0 (iPad; U; CPU OS 3_2_1 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Mobile/7B405'})

      error = get_response_code_message(response.code, url)
    end
    return error
  end

  def get_response_code_message(code, url)
    case code
      when 200...205
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
