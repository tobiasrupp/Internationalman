atom_feed :language => I18n.locale do |feed|
  feed.title @title
  feed.updated @updated


  @articles.each do |article|
    feed.entry(article) do |entry|
      entry.title(article.title)
      entry.content(article.ctry, :type => 'text')
      entry.author(article.author)
      entry.url stories_url
    end
  end
end
