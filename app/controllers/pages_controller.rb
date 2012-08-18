class PagesController < ApplicationController
  def home

  end

  def main
    # find all categories with stories for 2. level of navigation list
    @story_categories = []
    story_categories = Category.find(:all,                                  
                                  :include => :articles,
                                  :conditions =>"name <> 'Corporate'",
                                  :order => "display_sequence DESC")
    for category in story_categories
      if !category.articles.empty?
        @story_categories<<category
      end
    end
    if @story_categories.count == 0
      @page_body = "<p>Keine Kategorien gefunden. Pflege die Kategorien #{ view_context.link_to('hier', admin_categories_path )} .</p>"
    end

    # find the most recent story 
    current_article = get_latest_story

    # determine category
    current_category = get_category_from_story(current_article)
    @stories = current_category.articles

  end

  def contact
  	if !page = Page.find_by_page_type('CONTACT')
  		@page_body = "<p>Dies ist nur ein Beispieltext. Der richtige Text kann #{ view_context.link_to('hier', admin_pages_path )} gepflegt werden.</p>"
  		@page_title = 'Beispieltitel'
  	else
  		@page_body = page.body	
  		@page_title = page.title
  	end
  end

  def about
  	if !page = Page.find_by_page_type('ABOUT')
  		@page_body = "<p>Dies ist nur ein Beispieltext. Der richtige Text kann #{ view_context.link_to('hier', admin_pages_path ) } gepflegt werden.</p>"
  		@page_title = 'Beispieltitel'
  	else
  		@page_body = page.body	
  		@page_title = page.title
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
