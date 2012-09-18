class StoriesController < ApplicationController

  before_filter :set_status_message

  def show_stories
    # route /stories
    
    add_locale_to_url
  	
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

  	# get current story
    current_article = Article.find(:first,
                            :include => :categories,
                            :order => "published_date DESC")

    # get stories of the same category
    current_category = current_article.categories.first
    if !current_category.nil?
    	@selected_category = current_category
      @stories = current_category.articles
    end
    @selected_article = current_article  
    if long_titles?(@stories) 
      @content_section_column_width = 4
    else
      @content_section_column_width = 5
    end
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
      	@selected_article = @stories[0]
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
  	render action: "show_stories"
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
end
