Feature: Utilities
	In order to process data maintenance tasks
	As an admin
	I want to execute utility functions from the browser

Background:
	Given an admin user exists with email: "admin@example.com" and password: "password"
	
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
	| Neuer Radiobeitrag | N. Radiobeitr. | neuer-radiobeitrag | Deutschland | Alexander Bühler | Afrika, Drogenhandel | BBC         | 20110101       | http://www.spiegel.de | Buenaventura | -77.070229 | 3.886611 | de       |  

	And these video records exist
	| title              | short_title     | url_title          | ctry        | author           | categories          | broadcaster | broadcast_date | web_page              | address      | longitude  | latitude | language |  
	| Neues Video | N. Video | neues-video | Deutschland | Alexander Bühler | Asien, Drogenhandel | NDR         | 20100101       | http://www.spiegel.de | Buenaventura | -77.070229 | 3.886611 | de       |  

	And these post records exist
	| title          | short_title | url_title      | ctry        | author           | categories | address      | longitude  | latitude | language | publication_state | text     | text_2    |  
	| Neuer Blogpost | N. Post     | neuer-blogpost | Deutschland | Alexander Bühler | Corporate  | Buenaventura | -77.070229 | 3.886611 | de       | Published         | blogtext1 | blogtext2 |  

	@slow
	Scenario: Get the urls of all records that have a Facebook Like button and have been created or updated in a certain timeframe
		When I enter the path "/de/get_facebook_items_to_refresh?days=10" in the browser
		Then I should see "/de/stories/afrika/neuer-artikel"
		Then I should see "/de/stories/afrika/neuer-artikel-non-corp"
		Then I should see "/de/radio/neuer-radiobeitrag"
		Then I should see "/de/tv/neues-video"
		Then I should see "/de/blog/neuer-blogpost"
		When I enter the path "/de/get_facebook_items_to_refresh?days=0" in the browser
		Then I should see "/de/stories/afrika/neuer-artikel"
		Then I should see "/de/stories/afrika/neuer-artikel-non-corp"
		Then I should see "/de/radio/neuer-radiobeitrag"
		Then I should see "/de/tv/neues-video"
		Then I should see "/de/blog/neuer-blogpost"

	@slow
	Scenario: Rebuild search index
		When I enter the path "/de/rebuild_search_index" in the browser 
		And I authenticate on the login screen
		Then I should see "Index rebuilt"

	@slow
	Scenario: Get all recently updated records from remote website and update Facebook Like Button data with FB Linter Tool
		When I enter the path "/de/refresh_facebook_data_remote?days=100" in the browser
		And I authenticate on the login screen
		Then I should see "Completed successfully. Records updated"


