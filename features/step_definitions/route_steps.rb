# Scenario: Routing to frontend pages

When /^I enter the URL "(.*?)"$/ do |arg1|
  visit(arg1)
end

Then /^I should be on the "(.*?)"$/ do |arg1|
  current_path.should == path_to(arg1)
end

Then /^the page should be found$/ do
  page.should_not have_content("Not Found")
  page.should_not have_content("Routing Error")
  page.should_not have_content("No route matches")
end

