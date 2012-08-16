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
Given /^I am on the Main Page$/ do
  visit main_path
end