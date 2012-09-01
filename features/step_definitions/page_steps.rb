# Scenario: Show Homepage
When /^I go to www\.internationalman\.de$/ do
  visit root_path
end

Then /^I shoud see "(.*?)"$/ do |arg1|
  page.should have_content(arg1)
end

Then /^I shoud see a link "(.*?)"$/ do |arg1|
  page.should have_selector 'a', text: arg1	
end

Then /^i should see the page title "(.*?)"$/ do |arg1|
  page.should have_selector 'title', text: arg1	
end

# Scenario: Show Main Page in German
Given /^I am on the Homepage$/ do
  visit root_path
end

When /^I click on "(.*?)"$/ do |arg1|
  click_on arg1	
end

# Scenario: Show About Me Page

Given /^a page exists with title: "(.*?)", page_type: "(.*?)" and body: "(.*?)"$/ do |title, page_type, body|
  Page.create!(title: title, page_type: page_type, body: body)
end

Given /^I am on the Main Page$/ do
  visit main_path
end

# Scenario: Edit Contact Page

Given /^I am the Pages page$/ do
  visit('/admin/pages')
end

Given /^No page exists$/ do
  Page.count == 0
end

Then /^(\d+) page should exist$/ do |arg1|
  Page.count == arg1
end

When /^I go to the "(.*?)"$/ do |page|
  visit(path_to(page))
end

When /^I click on radio button "(.*?)"$/ do |arg1|
  choose(arg1)
end
