@focus
Feature: Map
	In order to view stories, radio tracks, videos and blog posts and their geographical location 
	As a user
	I want to use the map functionality 

Background:
	Given an admin user exists with email: "admin@example.com" and password: "password"
	And I log in with this user
	And the following categories records
		| name         | display_sequence | display_section | url_name     | language |  
		| Afrika       | 1                | 1               | afrika       | de       |  
		| Asien        | 2                | 1               | asien        | de       |  
		| Waffenhandel | 1                | 2               | waffenhandel | de       |  
		| Drogenhandel | 2                | 2               | drogenhandel | de       |  
		| Corporate    |                  |                 | corporate    | de       |  
	And these article records exist
	| title                       | short_title          | url_title              | ctry        | author           | photos_by    | categories                      | published_in | published_date | article_type | web_page              | address      | longitude  | latitude | language |  
	| Neuer Artikel               | N. Artikel           | neuer-artikel          | Deutschland | Alexander Bühler | Luca Zanetti | Afrika, Waffenhandel, Corporate | Die Zeit     | 20120101       | Titelseite   | http://www.spiegel.de | Buenaventura | -77.070229 | 3.886611 | de       |  
	| Neuer Artikel non Corporate | N. Artikel non Corp. | neuer-artikel-non-corp | Deutschland | Alexander Bühler | Luca Zanetti | Afrika, Waffenhandel            | Die Zeit     | 20120101       | Titelseite   | http://www.spiegel.de | Buenaventura | -77.070229 | 3.886611 | de       |  

	And these radio track records exist
	| title              | short_title     | url_title          | ctry        | author           | categories          | broadcaster | broadcast_date | web_page              | address      | longitude  | latitude | language |  
	| Neuer Radiobeitrag | N. Radiobeitrag | neuer-radiobeitrag | Deutschland | Alexander Bühler | Asien, Drogenhandel | BBC         | 20110101       | http://www.spiegel.de | Buenaventura | -77.070229 | 3.886611 | de       |  

	And these video records exist
	| title              | short_title     | url_title          | ctry        | author           | categories          | broadcaster | broadcast_date | web_page              | address      | longitude  | latitude | language |  
	| Neues Video | N. Video | neues-video | Deutschland | Alexander Bühler | Asien, Drogenhandel | NDR         | 20100101       | http://www.spiegel.de | Buenaventura | -77.070229 | 3.886611 | de       |  

	And these post records exist
	| title         | short_title | url_title      | ctry        | author           | categories | address      | longitude  | latitude | language | publication_state |  
	| Neuer Blogpost | N. Post     | neuer-blogpost | Deutschland | Alexander Bühler | Corporate  | Buenaventura | -77.070229 | 3.886611 | de       | Published         |  

	Scenario: Display Article Video and Radio Track on Map
		When I go to the "Map page"
		# contained in map javascript code, visible on icon click
		Then I should see "Neuer Artikel"
		And I should see "Afrika"
		And I should see "Waffenhandel"
		And I should see "Corporate"
		And I should see "Die Zeit"
		And I should see "January 01, 2012"
		And I should see "Titelseite"
		And I should see "Neuer Artikel non Corporate"
		# radio track
		And I should see "Neuer Radiobeitrag"
		And I should see "Asien"
		And I should see "Drogenhandel"
		And I should see "BBC"
		And I should see "January 01, 2011"
		# video
		And I should see "Neues Video"
		And I should see "NDR"
		And I should see "January 01, 2010"
		# post
		And I should see "Neuer Blogpost"
		And I should see "Deutschland"
		And I should see "Corporate"
		And I should see "Alexander Bühler"

		


