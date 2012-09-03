class StoriesController < ApplicationController

  def show_stories
    # route /stories
    
    add_locale_to_url
  	
    # get categories with stories (non-corporate)
  	story_categories = Category.find(:all,                                  
	                        :include => :articles,
	                        :conditions =>"name <> 'Corporate'",
	                        :order => "display_section ASC, display_sequence ASC")
    if story_categories.count == 0
      flash.now[:notice] = "Keine Kategorien gefunden."
      return
    end
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
  	current_article = get_latest_story

    # get stories of the same category
    current_category = get_category_from_story(current_article)
    if !current_category.nil?
    	@selected_category = current_category
      @stories = current_category.articles
    end
    @selected_article = current_article  
  end

  def show_stories_by_category

  	# route /stories/category

  	if !params[:category]
  		return
  	end 
  	
  	# get categories with stories (non-corporate)
  	story_categories = Category.find(:all,                                  
	                        :include => :articles,
	                        :conditions =>"name <> 'Corporate'",
	                        :order => "display_section ASC, display_sequence ASC")
    if story_categories.count == 0
      flash.now[:notice] = "Keine Kategorien gefunden."
      return
    end
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
      		end	
      	end
        if @selected_article.nil?
          # requested story unknown
          flash.now[:error] = "Story '#{params[:article_title]}' in Kategorie '#{params[:category]}' wurde nicht gefunden."
        end
      else	
      	@selected_article = @stories[0]
    	end
    else  
    	# category unknown
    	flash.now[:error] = "Kategorie '#{params[:category]}' wurde nicht gefunden."
    end
  	render action: "show_stories"
  end

  def feed
    # this will be the name of the feed displayed on the feed reader
    @title = t(:alexander_buehler) + " - Journalist"

    # the news items
    @articles = Article.find(:all,
                :include => :categories,
                :order => "published_date DESC")

    # this will be our Feed's update timestamp
    @updated = @articles.first.published_date unless @articles.empty?

    respond_to do |format|
      format.atom { render :layout => false }

      # we want the RSS feed to redirect permanently to the ATOM feed
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end
  end

private

  def get_latest_story
    articles = Article.find(:all,
                            :include => :categories,
                            :order => "published_date DESC")
    
    current_article = Article.new
    articles.each do |article|
      article.categories.each do |category|
        if category.name != "Corporate"
          return article        
        end     
      end
    end
  end
  def get_category_from_story(story)
    if story.categories.nil?
      return
    end
    if story.categories.count == 1
      return story.categories[0]
    else
      # determine category priority
      story_categories = Category.find(:all,                                  
              :include => :articles,
              :conditions =>"name <> 'Corporate'",
              :order => "display_section ASC, display_sequence ASC")
      story_categories.each do |category|  
        story.categories.each do |story_category|
          if category == story_category
            return category
          end
        end
      end
    end  
  end 
end
