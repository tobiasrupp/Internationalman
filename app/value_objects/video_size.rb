class VideoSize
	attr_reader :viewer_width
	attr_reader :viewer_height
	attr_reader :teaser_image_size

	def initialize(video)
    max_width = 380
    calculate_viewer_size(video, max_width)
    calculate_teaser_image_size(video)
  end

private
	attr_writer :viewer_width
	attr_writer :viewer_height
	attr_writer :teaser_image_size

	def calculate_viewer_size(video, max_width)
		width = video.video_width
		height = video.video_height
	  display_width = max_width
    if width.blank? or height.blank?
      # size not supplied, use max viewer size
      self.viewer_width = display_width
      self.viewer_height = @viewer_width / 16 * 9
      return
    end
    # size supplied
    width = width.to_f
    height = height.to_f
    if width <= display_width
    	# smaller than max width, use requested size
      self.viewer_width = width.to_i
      self.viewer_height = height.to_i
      return
    end  
  	# wider than max width, scale viewer down to max width
    ratio = width / display_width
    height = height / ratio
    self.viewer_height = height.to_i
    self.viewer_width = display_width
	end
	
	def calculate_teaser_image_size(video)
		aspect_ratio = video.video_aspect_ratio
    # scale image from aspect ratio if supplied
  	return self.teaser_image_size = :sixteen_nine if aspect_ratio.nil? or aspect_ratio.blank?
  	return self.teaser_image_size = :sixteen_nine if aspect_ratio == '16:9'
  	return self.teaser_image_size = :four_three if aspect_ratio == '4:3'
  	return self.teaser_image_size = :original #custom aspect ratio
	end	
end