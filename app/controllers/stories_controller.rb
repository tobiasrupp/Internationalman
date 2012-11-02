class StoriesController < ApplicationController

  def show_stories
    # route /stories

  	# get current story
    current_article = Article.find(:first,
                            :include => :categories,
                            :order => "published_date DESC")
    
    return flash.now[:notice] = "Keine Stories gefunden." if current_article.nil?
     
    # get stories of the same category
    current_category = current_article.categories.first
    return flash.now[:error] = "Keine Stories mit Kategorien gefunden." if current_category.nil?

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
    return flash.now[:notice] = "Keine Stories mit Kategorien gefunden." if @story_categories.count == 0

  	# get all stories of requested category sorted by published_date
  	current_category = Category.find_by_url_name(params[:category])

    # category unknown
    return flash.now[:error] = "Kategorie '#{params[:category]}' wurde nicht gefunden." if current_category.nil?

    @stories = current_category.articles
    @selected_category = current_category
    if !params[:article_title]
     # article parameter has not been provided, display current article 
      current_article = @stories[0]
      redirect_to :action => :show_stories_by_category, :category => current_category.url_name, :article_title => current_article.url_title, :only_path => true
      return
    end
    @selected_article = get_selected_article(@stories, params[:article_title])
    
    # requested story unknown
    return flash.now[:error] = "Story '#{params[:article_title]}' wurde nicht gefunden." if @selected_article.nil?

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
    end
    return story_categories
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
      return 4 if long_titles?(stories) 
      return 5
  end
end
