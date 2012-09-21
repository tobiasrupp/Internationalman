# Scenario: Create Valid Article

Given /^an admin user exists with email: "(.*?)" and password: "(.*?)"$/ do |arg1, arg2|
  create_model('admin_user', {email: arg1, password: arg2})
end

Given /^I log in with this user$/ do
  visit('/en/admin')
  fill_in('E-Mail', with: "admin@example.com")
  fill_in('Password', with: 'password')
  # save_and_open_page
  click_button('Login')
end

Given /^no article exists$/ do
  Article.count == 0
end

Given /^I am on the articles page$/ do
  visit('/en/admin/articles')
  current_path.should == '/en/admin/articles'
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

# Scenario: Navigate to article by click Dashboard link

Given /^1 article exists with title: "(.*?)"$/ do |arg1|
  create_model('article', {title: arg1})
end

Given /^I am on on the Dashboard$/ do
  visit('/en/admin')
  current_path.should == '/en/admin'
end

When /^I click on the link "(.*?)"$/ do |arg1|
  click_on(arg1)
end

