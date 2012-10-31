Feature: Manage Videos
	In order to display videos on the website in the TV section
	As a site admin or a user
	I want to create, show, edit and delete videos or find and watch videos

Background:
	Given an admin user exists with email: "admin@example.com" and password: "password"
	And I log in with this user
	And the following categories records
	| name      | display_sequence | display_section | url_name  | language |  
	| Afrika    | 2                | 1               | afrika    | de       |  
	| Corporate |                  |                 | corporate | de       |  

Scenario: Create video and show it on different pages
	
# Create video 
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

# Display video (frontend)
	When I go to the "TV page"
	And I should see "Neues Testvideo"
	And I should see "WDR"

#	Videos page (backend)
	When I go to the "Videos page"
	Then I should see "Id"
	And I should see "Title"
	And I should see "Short Title"
	And I should see "Categories"
	And I should see "Broadcast Date"
	And I should see "Teaser Image EN"
	And I should see "Copyr."
	And I should see "Lang."
	And I should see "Switch To German"
	And I should see "Switch To English"

# Switch to German
	When I click on "Switch To German"
	Then I should see "Teaser Image"
	And I should not see "Teaser Image EN"
	When I click on "Switch To English"
	And I go to the "Dashboard"

# Dashboard
	Then I should see "Recent Videos"
	When I click on "Neues Testvideo"
	
# Show Video
	Then I should see "Video Details"
	And I should see "Neues Testvideo"
	When I click on "Edit Video"

# Edit Video
	Then I should see "Edit Video"
	And I should see "Switch To German"
	And I should see "Switch To English"

Scenario: Show video with 'long' short title 
	Given these video records exist
	| title       | short_title                  | url_title   | categories | broadcast_date | address | language |  
	| Neues Video | N. Video long long long long | neues-video | Afrika     | 20100101       | Togo    | de       |  

	And I go to the "TV page"
	Then I should see "N. Video long long long long"

Scenario: Show video with 'long' short title and size information given
	Given these video records exist
	| title       | short_title                  | url_title   | categories | broadcast_date | address | video_width | video_height | video_aspect_ratio | language |  
	| Neues Video | N. Video long long long long | neues-video | Afrika     | 20100101       | Togo    | 100         | 100          | 16:9               | de       |  

	And I go to the "TV page"
	Then I should see "N. Video long long long long"

Scenario: Show video with 'long' short title and large width
	Given these video records exist
	| title       | short_title                  | url_title   | categories | broadcast_date | address | video_width | video_height | video_aspect_ratio | language |  
	| Neues Video | N. Video long long long long | neues-video | Afrika     | 20100101       | Togo    | 500         | 320          | 16:9               | de       |  

	And I go to the "TV page"
	Then I should see "N. Video long long long long"

Scenario: Show video with 'normal' short title and size information given
	Given these video records exist
	| title       | short_title | url_title   | categories | broadcast_date | address | video_width | video_height | video_aspect_ratio | language |  
	| Neues Video | N. Vid.     | neues-video | Afrika     | 20100101       | Togo    | 100         | 100          | 4:3                | de       |  

	And I go to the "TV page"
	Then I should see "N. Vid."

Scenario: Show video with 'normal' short title and large width
	Given these video records exist
	| title       | short_title | url_title   | categories | broadcast_date | address | video_width | video_height | video_aspect_ratio | language |  
	| Neues Video | N. Vid.    | neues-video | Afrika     | 20100101       | Togo    | 500         | 320          | 16:9               | de       |  

	And I go to the "TV page"
	Then I should see "N. Vid."

Scenario: Show error message when there are no videos in the database
	When I go to the "TV page"
	Then I should see "Kein TV-Beitrag gefunden"

Scenario: Show error message when the video passed in the url does not exist
	Given these video records exist
	| title       | short_title | url_title   | categories | broadcast_date | address | language |  
	| Neues Video | N. Video    | neues-video | Afrika     | 20100101       | Togo    | de       |  
	When I enter the path "/de/tv/strange" in the browser 
	Then I should see "TV-Beitrag 'strange' wurde nicht gefunden"
