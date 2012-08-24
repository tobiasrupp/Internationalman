# Scenario: Create Post

When /^I choose radio button "(.*?)" with "(.*?)"$/ do |rb_name, rb_choice|
  choose(rb_choice)
end
