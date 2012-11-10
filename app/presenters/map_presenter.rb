class MapPresenter < BasePresenter
  presents :data 
  attr_reader :to_json

  def to_json
    articles_json = build_articles_json
    radio_tracks_json = build_generic_json(data[:radio_tracks], 'radio_track', 'Radio')
    @json = articles_json.chop + ',' + radio_tracks_json[1..-1]
    videos_json = build_generic_json(data[:videos], 'video', 'TV')
    @json = @json.chop + ',' + videos_json[1..-1]
    posts_json = build_generic_json(data[:posts], 'post', 'Blog')
    @json = @json.chop + ',' + posts_json[1..-1]
    return @json
  end
  
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
  def build_generic_json(data, type, suffix)
    json = data.to_gmaps4rails do |object, marker|
      marker.infowindow send("#{type}_summary", object)
      marker.title object.title + ' (' + suffix + ')'
      marker.json({ :id => object.id })
    end
    return json
  end

  def article_summary(article)
    render :partial => 'stories/story_summary', :locals => {:@selected_article => article, :@format_for_map => true}
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

