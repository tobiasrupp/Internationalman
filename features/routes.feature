Feature: Routes
	In order to access the website content
	As a user
	I want to see and use nice clean RESTful routes

Scenario: Routing to frontend pages
	When I enter the URL "/"
	Then I should see "| Startseite"
	And I should be on the "Homepage"
	
	When I enter the URL "/contact"
	Then the page should be found
	
	When I enter the URL "/about"
	Then the page should be found

	When I enter the URL "/tv"
	Then the page should be found

	When I enter the URL "/radio"
	Then the page should be found

	When I enter the URL "/corporate"
	Then the page should be found

	When I enter the URL "/blog"
	Then the page should be found

	When I enter the URL "/stories"
	Then the page should be found


