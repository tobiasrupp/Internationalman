class CorporateArticlesController < ApplicationController
  
  # before_filter :set_status_message

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
          @show_fb_like_button = true
    		end	
    	end
      if @selected_article.nil?
        # requested story unknown
        flash.now[:error] = "Corporate Artikel '#{params[:article_title]}' wurde nicht gefunden."
      end
    else	
    	current_article = @stories[0]
      redirect_to :action => :show, :article_title => current_article.url_title, :only_path => true
      return
  	end
    if long_titles?(@stories) 
      @content_section_column_width = 5
    else
      @content_section_column_width = 6
    end
  end
end
