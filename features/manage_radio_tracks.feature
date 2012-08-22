Feature: Manage Radio Tracks
	In order to display and listen to radio audio tracks on the website in the Radio section
	As a site admin or a user
	I want to create, show, edit and delete audio tracks or find and listen to audio tracks

Background:
	Given an admin user exists with email: "admin@example.com" and password: "password"
	And I log in with this user
	And the following categories records
		|name|display_sequence|display_section|url_name|
		|Afrika|2|1|afrika|
		|Corporate|||corporate|
		
Scenario: 