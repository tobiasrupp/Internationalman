class PagesController < ApplicationController
  
  def map
    
    @articles = Article.find(:all,
                :include => :categories,
                :order => "published_date DESC")
    @radio_tracks = RadioTrack.find(:all,
                :include => :categories,
                :order => "broadcast_date DESC")
    @videos = Video.find(:all,
                :include => :categories,
                :order => "broadcast_date DESC")
    @posts = Post.find(:all,
                :include => :categories,
                :conditions => "publication_state = 'Published'",
                :order => "created_at DESC")

    @format_for_map = true

    articles_json = @articles.to_gmaps4rails do |article, marker|
      @is_corporate = false
      article.categories.each do |category|
        if category.name == 'Corporate'
          @is_corporate = true
          break
        end
      end
      @selected_article = article
      marker.infowindow render_to_string(:partial => "/stories/story_details")
      if @is_corporate == true
        marker.title   article.title + ' (Corporate)'
        marker.json({ :id => article.id, "picture" => "/assets/clothers_male_b_w.png",
           "width" => 32,
           "height" => 37,
           "shadow_picture" => "http://maps.google.com/mapfiles/shadow50.png" ,
           "shadow_width" => "37",
           "shadow_height" => "34",
           "shadow_anchor" => [10, 34]
          })
      else
        marker.title   article.title + ' (Stories)'
        marker.json({ :id => article.id })
      end
    end
    @selected_article = nil
    @is_corporate = false

    radio_tracks_json = @radio_tracks.to_gmaps4rails do |radio_track, marker|
      @selected_track = radio_track
      marker.infowindow render_to_string(:partial => "/radio_tracks/radio_track_details")
      marker.title   radio_track.title + ' (Radio)'
      marker.json({ :id => radio_track.id })
    end
    @selected_track = nil
    @json = articles_json.chop + ',' + radio_tracks_json[1..-1]

    videos_json = @videos.to_gmaps4rails do |video, marker|
      @selected_video = video
      marker.infowindow render_to_string(:partial => "/videos/video_details")
      marker.title   video.title + ' (TV)'
      marker.json({ :id => video.id })
    end
    @selected_video = nil
    @json = @json.chop + ',' + videos_json[1..-1]

    posts_json = @posts.to_gmaps4rails do |post, marker|
      @selected_post = post
      marker.infowindow render_to_string(:partial => "/posts/post_details")
      marker.title   post.title + ' (Blog)'
      marker.json({ :id => post.id })
    end
    @selected_post = nil
    @json = @json.chop + ',' + posts_json[1..-1]

    @format_for_map = false
    
    render(:layout => 'map')
  end


  def contact
    # add_locale_to_url
    
  	if !@page = Page.find_by_page_type('CONTACT')
      @page = Page.new
  		@page.body = "<span class=\"alert alert-info\">Dies ist nur ein Beispieltext. Der richtige Text kann #{ view_context.link_to('hier', admin_pages_path )} gepflegt werden.</span>"
  		@page.title = 'Beispieltitel'
  	end
    render(:layout => 'pages')
  end

  def about
  	if !@page = Page.find_by_page_type('ABOUT')
      @page = Page.new
  		@page.body = "<span class=\"alert alert-info\">Dies ist nur ein Beispieltext. Der richtige Text kann #{ view_context.link_to('hier', admin_pages_path ) } gepflegt werden.</span>"
  		@page.title = 'Beispieltitel'
  	end
    render(:layout => 'pages')
  end

  def map_without_javascript
    # @gmap_string = 'http://maps.googleapis.com/maps/api/staticmap?sensor=false&size=140x100&maptype=hybrid'

    # http://maps.googleapis.com/maps/api/staticmap?center=0,0&zoom=2&format=png&sensor=false&size=640x480&maptype=roadmap&style=invert_lightness:true|visibility:on
    # add markers
    # @articles = Article.all
    # @articles.each do |article|
    #   if !article.longitude.blank? and !article.latitude.blank?
    #     @gmap_string = @gmap_string + '&markers=size:small|color:orange|' + article.longitude + ',' + article.latitude
    #   end
    # end
    # @radio_tracks = RadioTrack.all
    # @radio_tracks.each do |radio_track|
    #   if !radio_track.longitude.blank? and !radio_track.latitude.blank?
    #     @gmap_string = @gmap_string + '&markers=size:small|color:red|' + radio_track.longitude + ',' + radio_track.latitude
    #   end
    # end
    # @videos = Video.all
    # @videos.each do |video|
    #   if !video.longitude.blank? and !video.latitude.blank?
    #     @gmap_string = @gmap_string + '&markers=size:small|color:blue|' + video.longitude + ',' + video.latitude
    #   end
    # end
    # @posts = Post.all
    # @posts.each do |post|
    #   if !post.longitude.blank? and !post.latitude.blank?
    #     @gmap_string = @gmap_string + '&markers=size:small|color:green|' + post.longitude + ',' + post.latitude
    #   end
    # end
  end
end
