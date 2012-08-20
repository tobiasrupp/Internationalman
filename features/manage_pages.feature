Feature: Manage Pages
	In order to get information about the journalist Alexander Bühler 
	As a user
	I want to be able to view his website

Background:
	Given an admin user exists with email: "admin@example.com" and password: "password"
	And I log in with this user

Scenario: Show Homepage
	When I go to www.internationalman.de
	Then I shoud see "Alexander Bühler"
	And I shoud see "Journalist"
	And I shoud see a link "Deutsch"
	And I shoud see a link "English"
	And i should see the page title "International Man | Startseite"

# Scenario: Show Main Page in German
# 	Given I am on the Homepage
# 	When I click on "Deutsch"
# 	Then i should see the page title "International Man | Menü"
# 	And I shoud see "Alexander Bühler"
# 	And I shoud see "Journalist"
# 	And I shoud see "Stories"
# 	And I shoud see "Blog"
# 	And I shoud see "Corporate"
# 	And I shoud see "TV"
# 	And I shoud see "Radio"
# 	And I shoud see "Über mich"
# 	And I shoud see "Kontakt"
	
# Scenario: Show About Me Page
# 	Given I am on the Main Page
# 	And a page exists with title: "Über mich", page_type: "ABOUT" and body: "Alexander Bühler, Journalist, Testbio"
# 	When I click on "Über mich"
# 	Then i should see the page title "International Man | Über mich"
# 	And I shoud see "Alexander Bühler"
# 	And I shoud see "Journalist"
# 	And I shoud see "Testbio"

# Scenario: Show Contact Page
# 	Given I am on the Main Page
# 	And a page exists with title: "Kontakt", page_type: "CONTACT" and body: "Alexander Bühler, Journalist, Email ..., Tel. ..."
# 	When I click on "Kontakt"
# 	Then i should see the page title "International Man | Kontakt"
# 	And I shoud see "Alexander Bühler"
# 	And I shoud see "Journalist"
# 	And I shoud see "Email"
# 	And I shoud see "Tel"

Scenario: Create Contact Page
	Given I am the Pages page
	And No page exists
	When I click on "New Page"
	And I fill in "Page type" with "CONTACT"
	And I fill in "Body" with "<h1>Example body text</h1>"
	And I fill in "Title" with "Contact test title"
	And I click on "Create Page"
	Then I should see "Page was successfully created"
	And 1 page should exist
	When I go to the "Contact page"
	Then I should see "Example body text"
	And I should see "Contact test title"








