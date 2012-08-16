Feature: Manage Articles
	In order to display articles on the website
	As a site admin
	I want to create, show, edit and delete articles

Scenario: Create Valid Article
	Given an admin user exists with email: "admin@example.com" and password: "password"
	And no article exists
	And I am on the articles page
	When I click on "New Article"
	And I fill in "Title" with "Neuer Artikel"
	And I fill in "Language" with "de"
	And I fill in selection field "Country" with "Colombia"
	And I fill in "Longitude" with "long"
	And I fill in "Latitude" with "lat"
	And I fill in "Article type" with "Titelgeschichte"
	And I fill in Published date with "12 March 2010"
	And I fill in "Published in" with "Die Zeit"
	And I fill in "Filename" with "article1.pdf"
	And I fill in "Author" with "Alexander Bühler"
	And I fill in "Photos by" with ""
	And I click on "Create Article"
	Then 1 article should exist
	And I should see "Article was successfully created"
	