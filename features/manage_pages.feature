Feature: Manage Pages
	In order to get information about the journalist Alexander Bühler 
	As a user
	I want to be able to view his website

Background:
	Given an admin user exists with email: "admin@example.com" and password: "password"
	And I log in with this user

Scenario: Create Page
	Given I am the Pages page
	And No page exists
	When I click on "erstellen"
	And I click on radio button "CONTACT"
	And I fill in "Text" with "Example body text"
	And I fill in "Title" with "Contact test title"
	And I click on "Create"
	Then 1 page should exist

# Display page (frontend)
	When I go to the "Contact page"
	Then I should see "Example body text"
	And I should see "Contact test title"

#	Videos page (backend)
	When I go to the "Pages page"
	Then I should see "Id"
	And I should see "Title"
	And I should see "Body"
	And I should see "Page Type"
	And I should see "Lang."
	And I should see "Switch To German"
	And I should see "Switch To English"
	When I click on "Edit"

# Edit page
	Then I should see "Edit Page"
	And I should see "Switch To German"
	And I should see "Switch To English"




