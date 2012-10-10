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
      end
    else	
    	current_video = @videos[0]
      redirect_to tv_path + '/' + current_video.url_title
      return
  	end
    if long_titles?(@videos) 
      @content_section_column_width = 5
    else
      @content_section_column_width = 6
    end
    set_video_viewer_size(@selected_video.video_width, @selected_video.video_height, @selected_video.video_aspect_ratio, @content_section_column_width)
    if !@selected_video.source_url.blank?
      array = @selected_video.source_url.split('video_player=')
      @video_player = array[1]
    end
  end

  private

  def set_video_viewer_size(width, height, aspect_ratio, column_width)

    case column_width
      when 5
        display_width = 380
        if width.blank? or height.blank?
          # use default viewer size
          @video_teaser_image_size = :sixteen_nine
          @video_viewer_width = display_width
          @video_viewer_height = @video_viewer_width / 16 * 9
        else
          width = width.to_f
          height = height.to_f
          if width <= display_width
            @video_viewer_width = width.to_i
            @video_viewer_height = height.to_i
          else
            ratio = width / display_width
            height = height / ratio
            @video_viewer_height = height.to_i
            @video_viewer_width = display_width
          end 
        end 
      when 6
        # display_width = 430 # a bit too wide for the iPhone
        display_width = 380
        if width.blank? or height.blank?
          # use default viewer size
          @video_teaser_image_size = :sixteen_nine
          @video_viewer_width = display_width
          @video_viewer_height = @video_viewer_width / 16 * 9
        else
          width = width.to_f
          height = height.to_f
          if width <= display_width
            @video_viewer_width = width.to_i
            @video_viewer_height = height.to_i
          else
            ratio = width / display_width
            height = height / ratio
            @video_viewer_height = height.to_i
            @video_viewer_width = display_width
          end 
        end
    end
    # select image size from aspect ratio
    case aspect_ratio 
      when '16:9'
        @video_teaser_image_size = :sixteen_nine
      when '4:3'
        @video_teaser_image_size = :four_three
      else
        # custom aspect ratio
        @video_teaser_image_size = :original
    end
  end
end
