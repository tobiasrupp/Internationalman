Feature: Facebook Integration
	In order to share articles, radio tracks etc on my Facebook profile
	As a user
	I want to use the Facebook Like Button 

Background:
	Given an admin user exists with email: "admin@example.com" and password: "password"
	And I log in with this user
	And the following categories records
		| name      | display_sequence | display_section | url_name  | language |  
		| Afrika    | 2                | 1               | afrika    | de       |  
		| Corporate |                  |                 | corporate | de       |  
	And these article records exist
	| title         | short_title | url_title     | ctry     | author           | photos_by    | categories        | published_in | published_date | article_type | web_page              | address      | longitude  | latitude | language |  
	| Neuer Artikel | N. Artikel  | neuer-artikel | Deutschland | Alexander Bühler | Luca Zanetti | Afrika, Corporate | Die Zeit     | 20120101       | Titelseite   | http://www.spiegel.de | Buenaventura | -77.070229 | 3.886611 | de       |  


Scenario: Display Article with Like Button
	When I go to the "Stories page"
	Then I should see "Neuer Artikel"
	And I should see "N. Artikel"
	And the url should contain "neuer-artikel"
	And I should see "Deutschland"
	And I should see "Alexander Bühler"
	And I should see "Luca Zanetti"
	And I should see "Afrika"
	And I should see "Corporate"
	And I should see "Die Zeit"
	And I should see "January 01, 2012"
	And I should see "Titelseite"
	And I should see "Online Article"
	And I should see the button "Show On Map"
	And I should see the button "Like"

Scenario: Facebook Open Graph meta tags must exist in page header for Like Button to work
	When I go to the "Stories page"
	Then the page should contain meta tag "og:title" with content "Neuer Artikel"
	And the page should contain meta tag "og:type" with content "article"
	And the page should contain meta tag "og:url" with content containing "neuer-artikel"
	And the page should contain meta tag "og:image" with content containing "globe_map.jpg"
	And the page should contain meta tag "og:site_name" with content "International Man - Alexander Buehler, Journalist"
	And the page should contain meta tag "fb:admins" with some content
	And the page should contain meta tag "og:description" with content containing keywords "Die Zeit, Titelseite, January 01, 2012, Deutschland, Alexander Bühler, Luca Zanetti, Afrika, Corporate" 
