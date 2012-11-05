class ServicesController < ApplicationController
  
	before_filter :authenticate_admin_user!, :except => [:get_facebook_items_to_refresh]

  def get_facebook_items_to_refresh
    return if params[:days].blank?
    
    starting_locale = I18n.locale
    all_urls = []
    set_locale(:de)
    all_urls = get_urls(all_urls)
    set_locale(:en)
    all_urls = get_urls(all_urls)

    set_locale(starting_locale)
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
      if Rails.env.test?
        # mock get request in test environment
        code = 200
      else 
        response = RestClient.get('http://developers.facebook.com/tools/debug/og/object', :params => {:q => url })
        code = response.code
      end
      error = get_response_code_message(code, url)
    else
      items = []
      if Rails.env.test?
        # mock get request in test environment, get data from local development environment
        request_root_url = "http://localhost:3001"
      else 
        request_root_url = "http://www.international-man.net"
      end
        items = RestClient.get("#{request_root_url}/de/get_facebook_items_to_refresh", :params => {:days => params[:days], :get_all => params[:refresh_all]})
      items.gsub!(/[\[\]]/,'')
      urls = items.split(', ')
      urls.each do |url|
        url.gsub!(/\A"|"\Z/, '')
        if Rails.env.test?
          # mock get request in test environment
          code = 200
        else 
          response = RestClient.get('http://developers.facebook.com/tools/debug/og/object', :params => {:q => url })
          code = response.code
        end
        error_occurred = get_response_code_message(code, url)
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

  def refresh_facebook_item
  end

private

  def get_urls(all_urls)
    all_urls += get_stories_to_refresh(params[:days])
    all_urls += get_radio_tracks_to_refresh(params[:days])
    all_urls += get_videos_to_refresh(params[:days])
    all_urls += get_corporate_articles_to_refresh(params[:days])
    all_urls += get_posts_to_refresh(params[:days])
  end

  def get_stories_to_refresh(no_of_days)
    no_of_days = no_of_days.to_i
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
    no_of_days = no_of_days.to_i
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
    no_of_days = no_of_days.to_i
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
    no_of_days = no_of_days.to_i
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
    no_of_days = no_of_days.to_i
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
