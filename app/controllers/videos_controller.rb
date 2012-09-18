class VideosController < ApplicationController
  
  before_filter :set_status_message

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
      end
    else	
    	@selected_video = @videos[0]
  	end
    if long_titles?(@videos) 
      @content_section_column_width = 5
      @video_viewer_width = 400
    else
      @content_section_column_width = 6
      @video_viewer_width = 450
    end
  end
end
