Feature: Manage Articles
	In order to display articles on the website
	As a site admin
	I want to create, show, edit and delete articles

Background:
	Given an admin user exists with email: "admin@example.com" and password: "password"
	And I log in with this user
	And the following categories records
		|name|display_sequence|display_section|url_name|
		|Afrika|2|1|afrika|
		|Corporate|||corporate|

Scenario: Create Article
	Given no article exists
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

Scenario: Navigate to article by clicking link on Dashboard 
	Given 1 article exists with title: "Ein neuer Artikel"
	And I am on on the Dashboard
	When I click on the link "Ein neuer Artikel"
	Then I should see "Article Details"
	And I should see "Ein neuer Artikel"

Scenario: Create Corporate Article
	Given no article exists
	And I am on the articles page
	When I click on "New Article"
	And I fill in "Title" with "Neuer Corporate Artikel"
	And I fill in "Short title" with "Corp. Artikel"
	And I fill in "Url title" with "neuer-corporate-artikel"
	And I fill in selection field "Categories" with "Corporate"
	And I fill in "Language" with "de"
	And I fill in selection field "Country" with "Colombia"
	And I fill in "Longitude" with "long"
	And I fill in "Latitude" with "lat"
	And I fill in "Article type" with "..."
	And I fill in Published date with "12 March 2010"
	And I fill in "Published in" with "Die Zeit"
	And I fill in "Filename" with "article1.pdf"
	And I fill in "Author" with "Alexander Bühler"
	And I fill in "Photos by" with ""
	And I fill in "Viewer url" with "..."
	And I fill in "Embed code" with "..."
	And I click on "Create Article"
	Then 1 article should exist
	And I should see "Article was successfully created"
	And 1 article_ids_category_ids records should exist
	When I go to the "Corporate page"
	And I should see "Neuer Corporate Artikel"
	And I should see "Die Zeit"


