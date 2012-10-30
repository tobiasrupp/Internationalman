Feature: Manage Status Messages
	In order to display status messages on the website
	As a site admin
	I want to create, show, edit and delete status message

Background:
	Given an admin user exists with email: "admin@example.com" and password: "password"
	And I log in with this user

Scenario: Create Status Message
	Given no "StatusMessage" exists
	And I go to the "Status Messages page"
	When I click on "New Status Message"
	And I fill in "Text" with "Neue Status Nachricht"
	And I click on "Create Statusmeldung"
	Then 1 "StatusMessage" should exist
	And I should see "Statusmeldung was successfully created"
	When I go to the "Homepage"
	And I should see "Neue Status Nachricht"
	When I go to the "Dashboard"

# Display Status Message (frontend)
	When I go to the "Homepage"
	And I should see "Neue Status Nachricht"

#	Status Messages page (backend)
	When I go to the "Status Messages page"
	Then I should see "Id"
	And I should see "Text"
	And I should see "Tweet"
	And I should see "Tweet Screen Name"
	And I should see "Created At"
	And I should see "Lang."
	And I should see "Switch To German"
	And I should see "Switch To English"
	When I go to the "Dashboard"

# Dashboard
	Then I should see "Recent Status Messages"
	And I click on "Neue Status Nachricht"
	
# Show Status Message
	Then I should see "Status Message Details"
	And I should see "Neue Status Nachricht"
	When I click on "Edit Status Message"

# Edit Status Message
	Then I should see "Edit Status Message"
	And I should see "Switch To German"
	And I should see "Switch To English"