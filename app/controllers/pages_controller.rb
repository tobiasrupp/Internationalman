class PagesController < ApplicationController
  def home
    render(:layout => 'intro')
  end

  def contact
  	if !page = Page.find_by_page_type('CONTACT')
  		@page_body = "<span class=\"label label-info\">Dies ist nur ein Beispieltext. Der richtige Text kann #{ view_context.link_to('hier', admin_pages_path )} gepflegt werden.</span>"
  		@page_title = 'Beispieltitel'
  	else
  		@page_body = page.body	
  		@page_title = page.title
  	end
    render(:layout => 'pages')
  end

  def about
  	if !page = Page.find_by_page_type('ABOUT')
  		@page_body = "<span class=\"label label-info\">Dies ist nur ein Beispieltext. Der richtige Text kann #{ view_context.link_to('hier', admin_pages_path ) } gepflegt werden.</span>"
  		@page_title = 'Beispieltitel'
  	else
  		@page_body = page.body	
  		@page_title = page.title
  	end
    render(:layout => 'pages')
  end
end
