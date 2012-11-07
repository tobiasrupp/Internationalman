class VideosController < ApplicationController

  def show
    
  	# get all videos to display them in 2. level navigation list sorted by broadcast date descending
		@videos = Video.find(:all,
	              :include => :categories,
	              :order => "broadcast_date DESC")
    return handle_error('no_item_found', 'TV-Beitrag') if @videos.count == 0
    return redirect_to_video(@videos[0]) if params[:video_title].blank?
    @selected_video = get_selected_item(@videos, params[:video_title])

    # requested video unknown
    return handle_error('item_not_found', 'TV-Beitrag', params[:video_title]) if @selected_video.nil?
   
    @show_fb_like_button = true
    @content_section_column_width = get_content_column_width(@videos)
    set_video_viewer_size(@selected_video.video_width, @selected_video.video_height, @selected_video.video_aspect_ratio)
    @video_player = get_media_player(@selected_video.source_url, 'video_player')
  end

private
  def redirect_to_video(video)
    redirect_to :action => :show, :video_title => video.url_title, :only_path => true
  end  

  def set_video_viewer_size(width, height, aspect_ratio)
    video_size = VideoSize.new(@selected_video) 
    @video_teaser_image_size = video_size.teaser_image_size 
    @video_viewer_width = video_size.viewer_width 
    @video_viewer_height = video_size.viewer_height
  end
end
