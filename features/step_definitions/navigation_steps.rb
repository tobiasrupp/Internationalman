# Scenario: Navigate to article

Given /^the following categories records$/ do |table|
  table.hashes.each do |hash|
  	Category.create!(hash)
  end
end

Given /^the following articles records$/ do |table|
  table.hashes.each do |hash|
  	Article.create!(hash)
  end
end

Given /^the following article_ids_category_ids records$/ do |table|
  table.hashes.each do |h|
		article = Article.find_by_title(h['article_title'])
  	category = Category.find_by_name(h['category_name'])
    article.categories<<category
  end
end

Then /^(\d+) article_ids_category_ids records should exist$/ do |arg1|
 	ArticleCategory.count.should == arg1.to_i
end
