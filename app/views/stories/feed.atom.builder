
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
        # entry.content('', :type => 'html')
        if !article.author.nil?
          entry.author do |author|
            author.name(article.author)
          end
        end
        puts entry.url
      end
  end
end
