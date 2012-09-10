Feature: Manage Status Messages
	In order to display status messages on the website
	As a site admin
	I want to create, show, edit and delete status message

Background:
	Given an admin user exists with email: "admin@example.com" and password: "password"
	And I log in with this user

@focus	
Scenario: Create Status Message
	Given no "StatusMessage" exists
	And I go to the "Status Messages page"
	When I click on "New Status Message"
	And I fill in "Text" with "Neue Status Nachricht"
	And I click on "Create Status message"
	Then 1 "StatusMessage" should exist
	And I should see "Status message was successfully created"
	When I go to the "Homepage"
	And I should see "Neue Status Nachricht"