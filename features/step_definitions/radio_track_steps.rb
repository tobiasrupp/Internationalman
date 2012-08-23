# Scenario: Create Radio Track

Given /^no "(.*?)" exists$/ do |model_name|
  find_models(model_name).size.should == 0
end

Then /^(\d+) "(.*?)" should exist$/ do |count, model_name|
  find_models(model_name).size.should == count.to_i
end

When /^I fill in Broadcast date of "(.*?)" with "(.*?)"$/ do |model_name, date_string|
  model_string = model_name.underscore
  date = date_string.split(' ')
  select(date[2], :from => "#{model_string}_broadcast_date_1i")
  select(date[1], :from => "#{model_string}_broadcast_date_2i")
  select(date[0], :from => "#{model_string}_broadcast_date_3i")
end


