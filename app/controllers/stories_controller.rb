class StoriesController < ApplicationController

  def show_stories
    # route /stories

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
    redirect_to :action => :show_stories_by_category, :category => current_category.url_name, :article_title => current_article.url_title, :only_path => true
  end

  def show_stories_by_category
  	# route /stories/category

  	if !params[:category]
  		return
  	end 
  	
  	# get categories with stories (non-corporate)
    story_categories = Category.find(:all,              
                          :include => [:translations, :articles],
                          :conditions => "name <> 'Corporate'",
                          :order => "display_section ASC, display_sequence ASC")
    
    @story_categories = []
    for category in story_categories
      if category.articles.size > 0
        @story_categories<<category
      end
    end
    if @story_categories.count == 0
      flash.now[:notice] = "Keine Stories mit Kategorien gefunden."
      return
    end

  	# get all stories of requested category sorted by published_date
  	current_category = Category.find_by_url_name(params[:category])

  	if current_category.nil?
      # category unknown
      flash.now[:error] = "Kategorie '#{params[:category]}' wurde nicht gefunden."
      return
    end  
    @stories = current_category.articles
    @selected_category = current_category
    if !params[:article_title]
     # article parameter has not been provided, display current article 
      current_article = @stories[0]
      redirect_to :action => :show_stories_by_category, :category => current_category.url_name, :article_title => current_article.url_title, :only_path => true
      return
    end
  	@stories.each do |story|
  		if story.url_title == params[:article_title]
  			@selected_article = story
        @show_fb_like_button = true
  		end	
  	end
    if @selected_article.nil?
      # requested story unknown
      flash.now[:error] = "Story '#{params[:article_title]}' wurde nicht gefunden."
      return
    end
    if long_titles?(@stories) 
      @content_section_column_width = 4
    else
      @content_section_column_width = 5
    end
  	render :action => "show_stories"
  end
end
