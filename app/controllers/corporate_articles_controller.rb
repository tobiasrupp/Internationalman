class CorporateArticlesController < ApplicationController
  
  def index
  end

  def show
    # add_locale_to_url
    
		# get all corporate articles to display them in 2. level navigation list sorted by published date descending
		@stories = Article.find(:all,
	              :include => :categories,
	              :conditions => "categories.name = 'Corporate'",
	              :order => "published_date DESC")
    if @stories.count == 0
      flash.now[:notice] = "Kein Corporate Artikel gefunden."
      return
    end
		# display details of current corporate article in content section
    if params[:article_title]
    	@stories.each do |story|
    		if story.url_title == params[:article_title]
    			@selected_article = story
    		end	
    	end
      if @selected_article.nil?
        # requested story unknown
        flash.now[:error] = "Corporate Artikel '#{params[:article_title]}' wurde nicht gefunden."
      end
    else	
    	@selected_article = @stories[0]
  	end
  end
end
