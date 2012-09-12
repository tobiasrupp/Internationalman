
atom_feed :language => 'en-US' do |feed|
  feed.title @title
  feed.updated @updated
              
  @articles.each do |article|
    category = article.categories.first
    feed.entry(article, :url => stories_path + '/' + category.url_name + '/' + article.url_title, :published => article.published_date, :updated => article.updated_at) do |entry|
      if !article.title.nil?
        entry.title(article.title)
      else
        entry.title(t(:no_text_found))
      end
      # entry.content('...', :type => 'html')
      entry.content((render :partial => '/stories/story_details.html.erb', :layout => false, :locals => {:selected_article => article}).html_safe, :type => 'html')
      if !article.author.nil?
        entry.author do |author|
          author.name(article.author)
        end
      end
      puts entry.url
    end
  end
  @posts.each do |post|
    feed.entry(post, :url => blog_path + '/' + post.url_title, :published => post.created_at, :updated => post.updated_at) do |entry|
      if !post.title.nil?
        entry.title(post.title)
      else
        entry.title(t(:no_text_found))
      end     
      entry.content('...', :type => 'html')
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
  @radio_tracks.each do |radio_track|
    feed.entry(radio_track, :url => radio_path + '/' + radio_track.url_title, :published => radio_track.broadcast_date, :updated => radio_track.updated_at) do |entry|
      if !radio_track.title.nil?
        entry.title(radio_track.title)
      else
        entry.title(t(:no_text_found))
      end
      entry.content('...', :type => 'html')
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
  @videos.each do |video|
    feed.entry(video, :url => tv_path + '/' + video.url_title, :published => video.broadcast_date, :updated => video.updated_at) do |entry|
      if !video.title.nil?
        entry.title(video.title)
      else
        entry.title(t(:no_text_found))
      end
      entry.content('...', :type => 'html')
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
end
