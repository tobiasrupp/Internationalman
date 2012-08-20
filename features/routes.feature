Feature: Routes
	In order to access the website content
	As a user
	I want to see and use nice clean RESTful routes

Background:
	Given an admin user exists with email: "admin@example.com" and password: "password"
	And I log in with this user
	And a page exists with title: "Über mich", page_type: "ABOUT" and body: "Alexander Bühler, Journalist, Testbio"
	And a page exists with title: "Kontakt", page_type: "CONTACT" and body: "Alexander Bühler, Journalist, Email ..., Tel. ..."
	And the following categories records
		|name|display_sequence|display_section|
		|Afrika|2|1|
		|Asien|1|1|
		|Lateinamerika|3|1|
		|Waffenhandel|1|2|
		|Corporate|||
	And the following articles records
		|title|language|author|published_date|published_in|photos_by|
		|Artikel1|Deutsch|Alex|20000101|Testo|T. Rupp|
		|Artikel2|Deutsch|Alex|20010101|Financial Times|Eiko Weishaupt|
		|Artikel3|Deutsch|Alex|20020101|ZDF|T. Rupp|
		|Artikel4|Deutsch|Alex|20030101|ARD|T. Rupp|
		|Artikel5|Deutsch|Alex|20040101|Eine Zeitung||
		|Artikel6|Deutsch|Alex|20050101|Der Spiegel|Eiko Weishaupt|
		|Artikel7|Deutsch|Alex|20060101|Die Zeit|Eiko Weishaupt|
		|Artikel8|Deutsch|Alex|20070101|BASF|Eiko Weishaupt|
		|Artikel9|Deutsch|Alex|20080101|Shell|Eiko Weishaupt|
	And the following article_ids_category_ids records
		|article_title|category_name|
		|Artikel1|Afrika|
		|Artikel2|Afrika|
		|Artikel3|Asien|
		|Artikel4|Asien|
		|Artikel5|Lateinamerika|
		|Artikel6|Waffenhandel|
		|Artikel7|Lateinamerika|
		|Artikel8|Corporate|
		|Artikel9|Corporate|
	Then 5 categories should exist
	And 9 articles should exist
	And 9 article_ids_category_ids records should exist

Scenario: Routing to frontend pages
	When I enter the URL "/"
	Then I should see "| Startseite"
	And I should be on the "Homepage"
	
	When I enter the URL "/contact"
	Then I should see "| Kontakt"
	And I should be on the "Contact page"
	
	When I enter the URL "/about"
	Then I should see "| Über mich"
	And I should be on the "About page"

	When I enter the URL "/TV"
	Then the page should be found




