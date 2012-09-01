Feature: Manage Videos
	In order to display videos on the website in the TV section
	As a site admin or a user
	I want to create, show, edit and delete videos or find and watch videos

Background:
	Given an admin user exists with email: "admin@example.com" and password: "password"
	And I log in with this user
	And the following categories records
	|name|display_sequence|display_section|url_name|language|
		|Afrika|2|1|afrika|de|
		|Corporate|||corporate|de|

Scenario: Create Video
	Given no "Video" exists
	And I go to the "Videos page"
	When I click on "New Video"
	And I fill in "Title" with "Neues Testvideo"
	And I fill in "Short title" with "N. Testvideo"
	And I fill in "Url title" with "neues-testvideo"
	And I fill in selection field "Categories" with "Afrika"
	And I fill in "Language" with "de"
	And I fill in "Country" with "Colombia"
	And I fill in "Longitude" with "long"
	And I fill in "Latitude" with "lat"
	And I fill in "Duration" with "15"
	And I fill in Broadcast date of "Video" with "12 March 2007"
	And I fill in "Broadcaster" with "WDR"
	And I fill in "Author" with "Alexander Bühler"
	And I fill in "Source url" with "http://www.example.com"
	And I fill in "Source url" with "http://www.example.com"
	And I click on "Create Video"
	Then 1 "Video" should exist
	And I should see "Video was successfully created"
	And 1 "VideoCategory" should exist
	When I go to the "TV page"
	And I should see "Neues Testvideo"
	And I should see "WDR"