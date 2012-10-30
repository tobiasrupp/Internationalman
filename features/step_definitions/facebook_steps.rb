# And /^the following articlex records$/ do |table|
#   # table.hashes.each do |attributes|
#   #   Article.create!(attributes)
#   # end
# end

Given /^these article records exist$/ do |table|
  table.hashes.each do |attributes|
  	attributes["categories"] = Category.where(:name => attributes["categories"].split(', ')).all
    article = Article.create!(attributes)
    # puts article.categories
  end
end

Then /^I should see the button "(.*?)"$/ do |button_name|
  case button_name
  	when 'Show On Map'
  		page.should have_css('.globe_btn')
  	when 'Like'
  		page.should have_css('.fb-like')
  	else
  		return false
  end
end

Then /^the url should contain "(.*?)"$/ do |path|
  current_path.should == "/#{I18n.locale}/stories/afrika/#{path}"
end

Then /^the page should contain meta tag "(.*?)" with content "(.*?)"$/ do |tag, content|
  tag = find(:xpath, "//head/meta[@property='#{tag}']")
  tag.native.attribute("content").value.should == content
end

Then /^the page should contain meta tag "(.*?)" with content containing "(.*?)"$/ do |tag, content|
  tag = find(:xpath, "//head/meta[@property='#{tag}']")
  tag.native.attribute("content").value.should include(content)
end

Then /^the page should contain meta tag "(.*?)" with some content$/ do |tag|
  tag = find(:xpath, "//head/meta[@property='#{tag}']")
  tag.native.attribute("content").value.should_not == ""
end

Then /^the page should contain meta tag "(.*?)" with content containing keywords "(.*?)"$/ do |tag, keywords|
  tag = find(:xpath, "//head/meta[@property='#{tag}']")
  keywords = keywords.split(', ')
  keywords.each do |keyword|
    tag.native.attribute("content").value.should include(keyword)
  end
end

