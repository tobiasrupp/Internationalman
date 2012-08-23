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

Scenario: Create Radio Track
	Given no "RadioTrack" exists
	And I go to the "Radio Track page"
	When I click on "New Radio Track"
	And I fill in "Title" with "Neuer Radiobeitrag Test"
	And I fill in "Short title" with "Rad. Beitrag"
	And I fill in "Url title" with "neuer-radiobeitrag"
	And I fill in selection field "Categories" with "Afrika"
	And I fill in "Language" with "de"
	And I fill in selection field "Country" with "Colombia"
	And I fill in "Longitude" with "long"
	And I fill in "Latitude" with "lat"
	And I fill in "Duration" with "12"
	And I fill in Broadcast date of "RadioTrack" with "12 March 2010"
	And I fill in "Broadcaster" with "NDR"
	And I fill in "Filename" with "article1.pdf"
	And I fill in "Author" with "Alexander Bühler"
	And I fill in "Source url" with "..."
	And I click on "Create Radio track"
	Then 1 "RadioTrack" should exist
	And I should see "Radio track was successfully created"
	And 1 "RadioTrackCategory" should exist
	When I go to the "Radio page"
	And I should see "Neuer Radiobeitrag Test"
	And I should see "NDR"