Feature: Routes
	In order to access the website content
	As a user
	I want to see and use nice clean routes

Background:
Given the following categories records
	| name         | display_sequence | display_section | url_name     | language |  
	| Afrika       | 1                | 1               | afrika       | de       |  
	And these article records exist
	| title         | short_title | url_title     | ctry        | author           | photos_by    | categories                      | published_in | published_date | article_type | web_page              | address      | longitude  | latitude | language |  
	| Neuer Artikel | N. Artikel  | neuer-artikel | Deutschland | Alexander Bühler | Luca Zanetti | Afrika, Waffenhandel, Corporate | Die Zeit     | 20120101       | Titelseite   | http://www.spiegel.de | Buenaventura | -77.070229 | 3.886611 | de       |  

Scenario: Routing to frontend pages
	When I enter the URL "/"
	Then I should see "| Stories"
	And the page should be found
	
	When I enter the URL "/en/contact"
	Then the page should be found
	
	When I enter the URL "/en/about"
	Then the page should be found

	When I enter the URL "/en/tv"
	Then the page should be found

	When I enter the URL "/en/radio"
	Then the page should be found

	When I enter the URL "/en/corporate"
	Then the page should be found

	When I enter the URL "/en/blog/ein-neuer-blog-eintrag"
	Then the page should be found

	When I enter the URL "/en/stories"
	Then the page should be found

	When I enter the URL "/en/stories/asien"
	Then the page should be found

	When I enter the URL "/en/stories/afrika/artikel-ueber-afrika"
	Then the page should be found

	When I enter the URL "/de/kontakt"
	Then the page should be found
	
	When I enter the URL "/de/ueber-mich"
	Then the page should be found

	When I enter the URL "/de/tv"
	Then the page should be found

	When I enter the URL "/de/radio"
	Then the page should be found

	When I enter the URL "/de/corporate"
	Then the page should be found

	When I enter the URL "/de/blog/ein-neuer-blog-eintrag"
	Then the page should be found

	When I enter the URL "/de/stories"
	Then the page should be found

	When I enter the URL "/de/stories/asien"
	Then the page should be found

	When I enter the URL "/de/stories/afrika/artikel-ueber-afrika"
	Then the page should be found

Scenario: Routing of invalid urls
	When I enter the URL "/de/stories/afrika/strange-article"
	Then I should see "Story 'strange-article' wurde nicht gefunden."
	When I enter the URL "/de/stories/strange-category"
	Then I should see "Kategorie 'strange-category' wurde nicht gefunden."


