Feature: Atom Feed
	In order to access the websites data with a newsreader
	As a user
	I want to subscribe to the atom feed

Background:
	Given the following categories records
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
	Scenario: Subscribe to Atom feed
		When I go to the "Homepage"
		And I click on "rss_feed"
		# Data is retrieved from development environment in this case
		Then the feed data sent from the webserver should contain keywords "Auf dem Weg ins Mittelalter"