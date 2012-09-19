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
    else
      @content_section_column_width = 6
    end
    set_video_viewer_size(@selected_video.video_width, @selected_video.video_height, @selected_video.video_aspect_ratio, @content_section_column_width)
  end

  private

  def set_video_viewer_size(width, height, aspect_ratio, column_width)
    case column_width
      when 5
        case aspect_ratio 
          when '16:9'
            @video_teaser_image_size = :sixteen_nine
            if width.blank? or height.blank?
              @video_viewer_width = 400
              @video_viewer_height = 225
              return
            end
            width = width.to_f
            height = height.to_f
            if width <= 400
              @video_viewer_width = width
              @video_viewer_height = @video_viewer_width / 16 * 9
            else
              @video_viewer_width = 400
              @video_viewer_height = 225
            end
            return
          when '4:3'
            @video_teaser_image_size = :four_three
            if width.blank? or height.blank?
              @video_viewer_width = 400
              @video_viewer_height = 300
              return
            end
            width = width.to_f
            height = height.to_f
            if width <= 400
              @video_viewer_width = width
              @video_viewer_height = @video_viewer_width / 4 * 3
            else
              @video_viewer_width = 400
              @video_viewer_height = 300
            end
            return
          else  
            @video_teaser_image_size = :sixteen_nine
            if width.blank? or height.blank?
              @video_viewer_width = 400
              @video_viewer_height = 300
              return
            end
            width = width.to_f
            height = height.to_f
            if width <= 400
              @video_viewer_width = width
              @video_viewer_height = height
            else
              ratio = width / 400
              height = height / ratio
              @video_viewer_height = height.to_i
              @video_viewer_width = 400
            end  
        end
      when 6
       case aspect_ratio 
        when '16:9'
          @video_teaser_image_size = :sixteen_nine
          if width.blank? or height.blank?
            @video_viewer_width = 450
            @video_viewer_height = 253
            return
          end
          width = width.to_f
          height = height.to_f
          if width <= 450
            @video_viewer_width = width
            @video_viewer_height = @video_viewer_width / 16 * 9
          else
            @video_viewer_width = 450
            @video_viewer_height = 253
          end
          return
        when '4:3'
          @video_teaser_image_size = :four_three
          if width.blank? or height.blank?
            @video_viewer_width = 450
            @video_viewer_height = 337
            return
          end
          width = width.to_f
          height = height.to_f
          if width <= 450
            @video_viewer_width = width
            @video_viewer_height = @video_viewer_width / 4 * 3
          else
            @video_viewer_width = 450
            @video_viewer_height = 337
          end
          return
        else  
          @video_teaser_image_size = :sixteen_nine
          if width.blank? or height.blank?
            @video_viewer_width = 450
            @video_viewer_height = 253
            return
          end
          width = width.to_f
          height = height.to_f
          if width <= 450
            @video_viewer_width = width
            @video_viewer_height = height
          else
            ratio = width / 450
            height = height / ratio
            @video_viewer_height = height.to_i
            @video_viewer_width = 450
          end  
      end 
    end
  end
end
