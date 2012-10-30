Feature: Search
	In order to find the stories, radio tracks, videos and blog posts I am interested in 
	As a user
	I want to use the full-text search functionality

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

	Scenario: Search with keywords
		When I go to the "Homepage"
		And I fill in "query" with "Alexander"
		And I click on "Suche"
		Then I should see "5 Dokumente gefunden"
		And I should see "Neuer Artikel"
		And I should see "Neuer Artikel non Corporate"
		And I should see "Neuer Radiobeitrag"
		And I should see "Neues Video"
		And I should see "Neuer Blogpost"

	# See if Unaccent Extension works
		And I fill in "query" with "Buhler"
		And I click on "Suche"
		Then I should see "5 Dokumente gefunden"

	# See if Prefix works
		And I fill in "query" with "Alex"
		And I click on "Suche"
		Then I should see "5 Dokumente gefunden"	

	# Multiple keywords
		And I fill in "query" with "Alexander Neu Corporate"
		And I click on "Suche"
		Then I should see "5 Dokumente gefunden"		

	# Case sensitivity
		And I fill in "query" with "alexander"
		And I click on "Suche"
		Then I should see "5 Dokumente gefunden"		

	# Check if all db field values are included in Suche index
		And I fill in "query" with "Blogpost"
		And I click on "Suche"
		Then I should see "Ein Dokument gefunden"	
		And I fill in "query" with "Radiobeitr."
		And I click on "Suche"
		Then I should see "Ein Dokument gefunden"
		And I fill in "query" with "neues-video"
		And I click on "Suche"
		Then I should see "Ein Dokument gefunden"
		And I fill in "query" with "asien"
		And I click on "Suche"
		Then I should see "Ein Dokument gefunden"
		And I fill in "query" with "asien"
		And I click on "Suche"
		Then I should see "Ein Dokument gefunden"
		And I fill in "query" with "blogtext1"
		And I click on "Suche"
		Then I should see "Ein Dokument gefunden"
		And I fill in "query" with "blogtext2"
		And I click on "Suche"
		Then I should see "Ein Dokument gefunden"
		And I fill in "query" with "Luca Zanetti"
		And I click on "Suche"
		Then I should see "2 Dokumente gefunden"

	# No keyword
		And I fill in "query" with "nonexistingtext"
		And I click on "Suche"
		Then I should see "Kein Dokument gefunden"

