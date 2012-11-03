class PagesController < ApplicationController
  
  def map
    # centre map with coordinates 
    if params[:lon] and params[:lat]
      @lon = params[:lon]
      @lat = params[:lat]
      @zoom = 5
    end  

    articles = Article.find(:all,
                :include => :categories,
                :order => "published_date DESC")
    radio_tracks = RadioTrack.find(:all,
                :include => :categories,
                :order => "broadcast_date DESC")
    videos = Video.find(:all,
                :include => :categories,
                :order => "broadcast_date DESC")
    posts = Post.find(:all,
                :include => :categories,
                :conditions => "publication_state = 'Published'",
                :order => "created_at DESC")

    @map_data = {:articles => articles, :radio_tracks => radio_tracks, :videos => videos, :posts => posts}

    render(:layout => 'map')
  end

  def contact
    @page = get_static_page('CONTACT')
    render(:layout => 'pages')
  end

  def about
  	@page = get_static_page('ABOUT')
    render(:layout => 'pages')
  end

  private

  def get_static_page(page_type)
    page = Page.where(:page_type => page_type).first
    if page.nil?  
      page = Page.new(:body => "<span class=\"alert alert-info\">Dies ist nur ein Beispieltext. Der richtige Text kann #{ view_context.link_to('hier', admin_pages_path )} gepflegt werden.</span>", :title => 'Beispieltitel')
    end
    return page
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
