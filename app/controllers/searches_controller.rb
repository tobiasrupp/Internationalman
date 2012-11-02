class SearchesController < ApplicationController
    
  before_filter :authenticate_admin_user!, :except => [:search]

  def search
  	if params[:query].blank?
      # flash.now[:error] = I18n.t(:enter_keywords) 
      return
    end
    if @hit_list = Article.text_search(params[:query])
      @no_of_hits = @hit_list.size
    else
      flash.now[:notice] = I18n.t(:no_documents_found)  
    end
    render(:layout => 'pages')
  end

  def rebuild_search_index
  	Article.rebuild_pg_search_documents
    flash[:notice] = "Index rebuilt."  
    redirect_to search_path
  end
end
