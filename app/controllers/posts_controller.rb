class PostsController < ApplicationController
  
  # before_filter :set_status_message
  
  def show
    # add_locale_to_url
    
		# get all published posts to display them in 2. level navigation list sorted by created_at descending
		@posts = Post.find(:all,
	              :include => :categories,
	              :conditions => "publication_state = 'Published'",
	              :order => "created_at DESC",
                :limit => 16)
    if @posts.count == 0
      flash.now[:notice] = "Kein Blogeintrag gefunden."
      return
    end
		# display details of current post in content section
    if params[:post_title]
    	@posts.each do |post|
    		if post.url_title == params[:post_title]
    			@selected_post = post
          @show_fb_like_button = true
    		end	
    	end
      if @selected_post.nil?
        # requested post unknown
        flash.now[:error] = "Blogeintrag '#{params[:post_title]}' wurde nicht gefunden."
      end
    else	
    	current_post = @posts[0]
      redirect_to :action => :show, :post_title => current_post.url_title, :only_path => true
      return
  	end
    if long_titles?(@posts) 
      @content_section_column_width = 5
    else
      @content_section_column_width = 6
    end
  end
end
