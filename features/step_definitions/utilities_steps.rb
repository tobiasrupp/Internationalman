When /^I enter the path "(.*?)" in the browser$/ do |arg1|
  visit(arg1)
end

When /^I authenticate on the login screen$/ do
  fill_in('E-Mail', with: "admin@example.com")
  fill_in('Password', with: 'password')
  # save_and_open_page
  click_button('Login')
end
