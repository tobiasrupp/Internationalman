class CorporateArticlesController < ApplicationController

  def show

		# get all corporate articles to display them sorted by published date descending
		@stories = Article.find(:all,
	              :include => :categories,
	              :conditions => "categories.name = 'Corporate'",
	              :order => "published_date DESC")
    return handle_error('no_item_found', 'Corporate Artikel') if @stories.count == 0
    return redirect_to_corp_article(@stories[0]) if params[:article_title].blank?
		@selected_article = get_selected_item(@stories, params[:article_title])

    # requested article unknown
    return handle_error('item_not_found', 'Corporate Artikel', params[:article_title]) if @selected_article.nil?
    
    @show_fb_like_button = true
    @content_section_column_width = get_content_column_width(@stories)
  end

private

  def redirect_to_corp_article(article)
    redirect_to :action => :show, :article_title => article.url_title, :only_path => true
  end  
end
