class PagesController < ApplicationController
  def home
  end

  def main
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
end
