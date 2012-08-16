# Scenario: Create Valid Article

Given /^an admin user exists with email: "(.*?)" and password: "(.*?)"$/ do |arg1, arg2|
  create_model('admin_user', {email: arg1, password: arg2})
end

Given /^no article exists$/ do
  Article.count == 0
end

Given /^I am on the articles page$/ do
  visit('/admin/articles')
  fill_in('Email', with: "admin@example.com")
  fill_in('Password', with: 'password')
  click_button('Login')
  current_path.should == '/admin/articles'
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |arg1, arg2|
  fill_in(arg1, with: arg2)
end

When /^I fill in Published date with "(.*?)"$/ do |date_string|
  date = date_string.split(' ')
  select(date[2], :from => 'article_published_date_1i')
  select(date[1], :from => 'article_published_date_2i')
  select(date[0], :from => 'article_published_date_3i')
end

Then /^I should see "(.*?)"$/ do |arg1|
  page.should have_content(arg1)
end

When /^I fill in selection field "(.*?)" with "(.*?)"$/ do |arg1, arg2|
  select(arg2, :from => arg1)
end

Then /^(\d+) article should exist$/ do |arg1|
  Article.count == arg1.to_i
end