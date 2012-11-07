class PostsController < ApplicationController

  def show
    
		# get all published posts to display them sorted by created_at descending
		@posts = Post.find(:all,
	              :include => :categories,
	              :conditions => "publication_state = 'Published'",
	              :order => "created_at DESC",
                :limit => 16)
    return handle_error('no_item_found', 'Blogeintrag') if @posts.count == 0
    return redirect_to_post(@posts[0]) if params[:post_title].blank?
    @selected_post = get_selected_item(@posts, params[:post_title])

    # requested post unknown
    return handle_error('item_not_found', 'Blogeintrag', params[:post_title]) if @selected_post.nil?
    
    @show_fb_like_button = true
    @content_section_column_width = get_content_column_width(@posts)
  end

private  

  def redirect_to_post(post)
    redirect_to :action => :show, :post_title => post.url_title, :only_path => true
  end  

  def get_content_column_width(stories)
    return 4 if long_titles?(stories) 
    return 5
  end
  
end
