class PagesController < ApplicationController
  
  def map
    # centre map with coordinates 
    if params[:lon] and params[:lat]
      @lon = params[:lon]
      @lat = params[:lat]
      @zoom = 5
      @auto_adjust = false
    else
      @auto_adjust = true
      @zoom = 0
    end  
    
    @gmap_string = 'http://maps.googleapis.com/maps/api/staticmap?sensor=false&size=140x100&maptype=hybrid'

    # http://maps.googleapis.com/maps/api/staticmap?center=0,0&zoom=2&format=png&sensor=false&size=640x480&maptype=roadmap&style=invert_lightness:true|visibility:on
    # add markers
    @articles = Article.all
    @articles.each do |article|
      if !article.longitude.blank? and !article.latitude.blank?
        @gmap_string = @gmap_string + '&markers=size:small|color:orange|' + article.longitude + ',' + article.latitude
      end
    end
    @radio_tracks = RadioTrack.all
    @radio_tracks.each do |radio_track|
      if !radio_track.longitude.blank? and !radio_track.latitude.blank?
        @gmap_string = @gmap_string + '&markers=size:small|color:red|' + radio_track.longitude + ',' + radio_track.latitude
      end
    end
    @videos = Video.all
    @videos.each do |video|
      if !video.longitude.blank? and !video.latitude.blank?
        @gmap_string = @gmap_string + '&markers=size:small|color:blue|' + video.longitude + ',' + video.latitude
      end
    end
    @posts = Post.all
    @posts.each do |post|
      if !post.longitude.blank? and !post.latitude.blank?
        @gmap_string = @gmap_string + '&markers=size:small|color:green|' + post.longitude + ',' + post.latitude
      end
    end
    @format_for_map = true
    @json = @articles.to_gmaps4rails do |article, marker|
      @selected_article = article
      marker.infowindow render_to_string(:partial => "/stories/story_details")
      # marker.picture({
      #                 :picture => "http://www.blankdots.com/img/github-32x32.png",
      #                 :width   => 32,
      #                 :height  => 32
      #                })
      marker.title   article.title
      # marker.sidebar "i'm the sidebar"
      marker.json({ :id => article.id })
    end
    @selected_article = nil
    @format_for_map = false
    render(:layout => 'map')
  end


  def contact
    # add_locale_to_url
    
  	if !page = Page.find_by_page_type('CONTACT')
  		@page_body = "<span class=\"alert alert-info\">Dies ist nur ein Beispieltext. Der richtige Text kann #{ view_context.link_to('hier', admin_pages_path )} gepflegt werden.</span>"
  		@page_title = 'Beispieltitel'
  	else
  		@page_body = page.body	
  		@page_title = page.title
  	end
    render(:layout => 'pages')
  end

  def about
  	if !page = Page.find_by_page_type('ABOUT')
  		@page_body = "<span class=\"alert alert-info\">Dies ist nur ein Beispieltext. Der richtige Text kann #{ view_context.link_to('hier', admin_pages_path ) } gepflegt werden.</span>"
  		@page_title = 'Beispieltitel'
  	else
  		@page_body = page.body	
  		@page_title = page.title
  	end
    render(:layout => 'pages')
  end
end
