class PostsController < ApplicationController
  def index
  end

  def show
    # add_locale_to_url
    
		# get all published posts to display them in 2. level navigation list sorted by updated_at descending
		@posts = Post.find(:all,
	              :include => :categories,
	              :conditions => "publication_state = 'Published'",
	              :order => "updated_at DESC")
    if @posts.count == 0
      flash.now[:notice] = "Kein Blogeintrag gefunden."
      return
    end
		# display details of current post in content section
    if params[:post_title]
    	@posts.each do |post|
    		if post.url_title == params[:post_title]
    			@selected_post = post
    		end	
    	end
      if @selected_post.nil?
        # requested post unknown
        flash.now[:error] = "Blogeintrag '#{params[:post_title]}' wurde nicht gefunden."
      end
    else	
    	@selected_post = @posts[0]
  	end
  end
end
