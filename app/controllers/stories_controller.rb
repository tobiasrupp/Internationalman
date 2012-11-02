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

  	# get categories with stories (non-corporate)
    categories = Category.find(:all,              
                          :include => [:translations, :articles],
                          :conditions => "name <> 'Corporate'",
                          :order => "display_section ASC, display_sequence ASC")
    
    @story_categories = get_categories_with_stories(categories)
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
    @selected_article = get_selected_article(@stories, params[:article_title])
    if @selected_article.nil?
      # requested story unknown
      flash.now[:error] = "Story '#{params[:article_title]}' wurde nicht gefunden."
      return
    end
    @show_fb_like_button = true
    @content_section_column_width = get_content_column_width(@stories)
  	render :action => "show_stories"
  end

private

  def get_categories_with_stories(categories)
    story_categories = []
    for category in categories
      if category.articles.count > 0
        story_categories<<category
      end
      return story_categories
    end
  end  

  def get_selected_article(articles, requested_article)
    selected_article = nil
    articles.each do |article|
      if article.url_title == requested_article
        selected_article = article
      end 
    end
    return selected_article
  end 

  def get_content_column_width(stories)
    if long_titles?(stories) 
      content_column_width = 4
    else
      content_column_width = 5
    end
  end
end
