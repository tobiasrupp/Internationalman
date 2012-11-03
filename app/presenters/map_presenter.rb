class MapPresenter < BasePresenter
  presents :data 
  attr_reader :to_json

  def to_json
    articles_json = build_articles_json
    radio_tracks_json = build_radio_tracks_json
    @json = articles_json.chop + ',' + radio_tracks_json[1..-1]
    videos_json = build_videos_json
    @json = @json.chop + ',' + videos_json[1..-1]
    posts_json = build_posts_json
    @json = @json.chop + ',' + posts_json[1..-1]
    return @json
  end
  
  # def avatar
  #   h.link_to_if user.url.present?, h.image_tag("avatars/#{avatar_name}", class: "avatar"), user.url
  # end
  
private

  def build_articles_json
    articles_json = data[:articles].to_gmaps4rails do |article, marker|
      is_corporate = corporate_article?(article)
      marker.infowindow article_summary(article)
      if is_corporate == true
        marker = corporate_article_json(article, marker)
      else
        marker.title  article.title + ' (Stories)'
        marker.json({ :id => article.id })
      end
    end
    return articles_json
  end 
  def build_radio_tracks_json
    radio_tracks_json = data[:radio_tracks].to_gmaps4rails do |radio_track, marker|
      marker.infowindow radio_track_summary(radio_track)
      marker.title  radio_track.title + ' (Radio)'
      marker.json({ :id => radio_track.id })
    end
    return radio_tracks_json
  end 
  def build_videos_json
    videos_json = data[:videos].to_gmaps4rails do |video, marker|
      marker.infowindow video_summary(video)
      marker.title  video.title + ' (TV)'
      marker.json({ :id => video.id })
    end
    return videos_json
  end 
  def build_posts_json
    posts_json = data[:posts].to_gmaps4rails do |post, marker|
      marker.infowindow post_summary(post)
      marker.title  post.title + ' (Blog)'
      marker.json({ :id => post.id })
    end
    return posts_json
  end 
  def article_summary(article)
    render :partial => 'stories/story_details', :locals => {:@selected_article => article, :@format_for_map => true}
  end
  def radio_track_summary(track)
    render :partial => 'radio_tracks/radio_track_details', :locals => {:@selected_track => track, :@format_for_map => true}
  end
  def video_summary(video)
    render :partial => 'videos/video_details', :locals => {:@selected_video => video, :@format_for_map => true}
  end
  def post_summary(post)
    render :partial => 'posts/post_details', :locals => {:@selected_post => post, :@format_for_map => true}
  end
  def corporate_article?(article)
    is_corporate = false
    article.categories.each do |category|
      if category.name == 'Corporate'
        is_corporate = true
        break
      end
    end
    return is_corporate
  end
  def corporate_article_json(article, marker)
    marker.title  article.title + ' (Corporate)'
    marker.json({ :id => article.id, "picture" => "/assets/clothers_male_b_w.png",
       "width" => 32,
       "height" => 37,
       "shadow_picture" => "http://maps.google.com/mapfiles/shadow50.png" ,
       "shadow_width" => "37",
       "shadow_height" => "34",
       "shadow_anchor" => [10, 34]
      })
    return marker
  end  
end

