
atom_feed :language => 'en-US' do |feed|
  feed.title @title
  feed.updated @updated
              
  @articles.each do |article|
    category = article.categories.first
    feed.entry(article, :url => stories_path + '/' + category.url_name + '/' + article.url_title, :published => article.published_date, :updated => article.updated_at) do |entry|
        entry.title(article.title)
        entry.content('Testocontent', :type => 'html')
        puts article.title
        puts entry.url
        if !article.author.nil?
          entry.author do |author|
            author.name(article.author)
          end
        end
      end
  end
end
