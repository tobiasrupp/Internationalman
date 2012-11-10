@feed = true 
atom_feed :language => 'en-US' do |feed|
  feed.title @title
  feed.updated @updated
              
  @articles.each do |article|
    category = article.categories.first
    feed.entry(article, :url => stories_path + '/' + category.url_name + '/' + article.url_title, :published => article.published_date, :updated => article.updated_at) do |entry|
      if !article.title.nil?
        entry.title("Stories - " + article.title)
      else
        entry.title("Stories - " + t(:no_text_found))
      end
      @selected_article = article
      entry.content((render :partial => 'stories/story_summary', :formats=>[:html], :handlers=>[:erb]).html_safe, :type => 'html')
      if !article.author.nil?
        entry.author do |author|
          author.name(article.author)
        end
      end
      # puts entry.url
    end
  end
  @selected_article = nil

  @posts.each do |post|
    feed.entry(post, :url => blog_path + '/' + post.url_title, :published => post.created_at, :updated => post.updated_at) do |entry|
      if !post.title.nil?
        entry.title("Blog - " + post.title)
      else
        entry.title("Blog - " + t(:no_text_found))
      end     
      @selected_post = post
      entry.content((render :partial => 'posts/post_details', :formats=>[:html], :handlers=>[:erb]).html_safe, :type => 'html')
      if !post.author.blank?
        entry.author do |author|
          author.name(post.author)
        end
      else
        entry.author do |author|
          author.name(t(:alexander_buehler))
        end
      end
      # puts entry.url
    end
  end
  @selected_post = nil

  @radio_tracks.each do |radio_track|
    feed.entry(radio_track, :url => radio_path + '/' + radio_track.url_title, :published => radio_track.broadcast_date, :updated => radio_track.updated_at) do |entry|
      if !radio_track.title.nil?
        entry.title("Radio - " + radio_track.title)
      else
        entry.title("Radio - " + t(:no_text_found))
      end
      @selected_track = radio_track
      entry.content((render :partial => 'radio_tracks/radio_track_details', :formats=>[:html], :handlers=>[:erb]).html_safe, :type => 'html')
      if !radio_track.author.blank?
        entry.author do |author|
          author.name(radio_track.author)
        end
      else
        entry.author do |author|
          author.name(t(:alexander_buehler))
        end
      end
      # puts entry.url
    end
  end
  @selected_track = nil

  @videos.each do |video|
    feed.entry(video, :url => tv_path + '/' + video.url_title, :published => video.broadcast_date, :updated => video.updated_at) do |entry|
      if !video.title.nil?
        entry.title("TV - " + video.title)
      else
        entry.title("TV - " + t(:no_text_found))
      end
      @selected_video = video
      entry.content((render :partial => 'videos/video_details', :formats=>[:html], :handlers=>[:erb]).html_safe, :type => 'html')
      if !video.author.blank?
        entry.author do |author|
          author.name(video.author)
        end
      else
        entry.author do |author|
          author.name(t(:alexander_buehler))
        end
      end
      # puts entry.url
    end
  end
  @selected_video = nil
end
