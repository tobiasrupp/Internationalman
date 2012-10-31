Feature: Manage Radio Tracks
	In order to display and listen to radio audio tracks on the website in the Radio section
	As a site admin or a user
	I want to create, show, edit and delete audio tracks or find and listen to audio tracks

Background:
	Given an admin user exists with email: "admin@example.com" and password: "password"
	And I log in with this user
	And the following categories records
	|name|display_sequence|display_section|url_name|language|
		|Afrika|2|1|afrika|de|
		|Corporate|||corporate|de|

Scenario: Create Radio Track
	Given no "RadioTrack" exists
	And I go to the "Radio Track page"
	When I click on "New Radio Track"
	And I fill in "Title" with "Neuer Radiobeitrag Test"
	And I fill in "Short title" with "Rad. Beitrag"
	And I fill in "Url title" with "neuer-radiobeitrag"
	And I fill in selection field "Categories" with "Afrika"
	And I fill in "Language" with "de"
	And I fill in "Country" with "Colombia"
	And I fill in "Longitude" with "long"
	And I fill in "Latitude" with "lat"
	And I fill in "Duration" with "12"
	And I fill in Broadcast date of "RadioTrack" with "12 March 2010"
	And I fill in "Broadcaster" with "NDR"
	And I fill in "Author" with "Alexander Bühler"
	And I fill in "Source url" with "http://www.example.com"
	And I click on "Create Radiobeitrag"
	Then 1 "RadioTrack" should exist
	And I should see "Radiobeitrag was successfully created"
	And 1 "RadioTrackCategory" should exist

# Display Radio Track (frontend)
	When I go to the "Radio page"
	And I should see "Neuer Radiobeitrag Test"
	And I should see "NDR"
	When I go to the "Dashboard"

# Dashboard
	Then I should see "Recent Videos"
	When I click on "Neuer Radiobeitrag Test"

# Show Video
	Then I should see "Radio Track Details"
	And I should see "Neuer Radiobeitrag Test"

#	Radio Track page (backend)
	When I go to the "Radio Track page"
	Then I should see "Id"
	And I should see "Title"
	And I should see "Short Title"
	And I should see "Categories"
	And I should see "Broadcast Date"
	And I should see "Copyr."
	And I should see "Lang."
	And I should see "Switch To German"
	And I should see "Switch To English"
	When I click on "Edit"

# Edit Radio Track
	Then I should see "Edit Radio Track"
	And I should see "Switch To German"
	And I should see "Switch To English"

Scenario: Show error message when there are no radio tracks in the database
	When I go to the "Radio page"
	Then I should see "Kein Radiobeitrag gefunden"

Scenario: Show error message when the radio track passed in the url does not exist
	Given these radio track records exist
	| title        | short_title | url_title | categories | broadcast_date | address | language |  
	| Radiobeitrag | Radiob.     | radio     | Afrika     | 20100101       | Togo    | de       |  
	When I enter the path "/de/radio/strange" in the browser 
	Then I should see "Radiobeitrag 'strange' wurde nicht gefunden"

Scenario: Show radio track with 'long' short title
	Given these radio track records exist
	| title        | short_title                 | url_title | categories | broadcast_date | address | language |  
	| Radiobeitrag | Radiob. long long long long | radio     | Afrika     | 20100101       | Togo    | de       |  
	When I go to the "Radio page"
	Then I should see "Radiob. long long long long"
