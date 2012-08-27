Feature: Routes
	In order to access the website content
	As a user
	I want to see and use nice clean RESTful routes

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

	# When I enter the URL "/blog/2010"
	# Then the page should be found

	# When I enter the URL "/blog/2010/9"
	# Then the page should be found

	# When I enter the URL "/blog/afrika"
	# Then the page should be found

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

	# When I enter the URL "/blog/2010"
	# Then the page should be found

	# When I enter the URL "/blog/2010/9"
	# Then the page should be found

	# When I enter the URL "/blog/afrika"
	# Then the page should be found

	When I enter the URL "/de/stories"
	Then the page should be found

	When I enter the URL "/de/stories/asien"
	Then the page should be found

	When I enter the URL "/de/stories/afrika/artikel-ueber-afrika"
	Then the page should be found
	# When I enter the URL "/stories/afrika/2001"
	# Then the page should be found

	# When I enter the URL "/stories/2001"
	# Then the page should be found


