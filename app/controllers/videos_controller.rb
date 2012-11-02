class VideosController < ApplicationController
  
  # before_filter :set_status_message

  def show
    # add_locale_to_url
    
  	# get all videos to display them in 2. level navigation list sorted by broadcast date descending
		@videos = Video.find(:all,
	              :include => :categories,
	              :order => "broadcast_date DESC")
    if @videos.count == 0
      flash.now[:notice] = "Kein TV-Beitrag gefunden."
      return
    end
		# display details of current video in content section
    if params[:video_title]
    	@videos.each do |video|
    		if video.url_title == params[:video_title]
    			@selected_video = video
          @show_fb_like_button = true
          break
    		end	
    	end
      if @selected_video.nil?
        # requested video unknown
        flash.now[:error] = "TV-Beitrag '#{params[:video_title]}' wurde nicht gefunden."
        return
      end
    else	
    	current_video = @videos[0]
      redirect_to :action => :show, :video_title => current_video.url_title, :only_path => true
      return
  	end
    if long_titles?(@videos) 
      @content_section_column_width = 5
    else
      @content_section_column_width = 6
    end
    set_video_viewer_size(@selected_video.video_width, @selected_video.video_height, @selected_video.video_aspect_ratio)
    if !@selected_video.source_url.blank?
      array = @selected_video.source_url.split('video_player=')
      @video_player = array[1]
    end
  end

  private

  def set_video_viewer_size(width, height, aspect_ratio)
    video_size = VideoSize.new(@selected_video) 
    @video_teaser_image_size = video_size.teaser_image_size 
    @video_viewer_width = video_size.viewer_width 
    @video_viewer_height = video_size.viewer_height
  end
end
