Feature: Manage Articles
	In order to display articles on the website
	As a site admin
	I want to create, show, edit and delete articles

Background:
	Given an admin user exists with email: "admin@example.com" and password: "password"
	And I log in with this user
	And the following categories records
		| name      | display_sequence | display_section | url_name  | language |  
		| Afrika    | 2                | 1               | afrika    | de       |  
		| Corporate |                  |                 | corporate | de       |  

Scenario: Create Article
	Given no article exists
	And I am on the articles page
	When I click on "New Article"
	And I fill in "Title" with "Neuer Artikel"
	And I fill in "Short title" with "N. Artikel"
	And I fill in "Url title" with "neuer-artikel"
	And I fill in "Language" with "de"
	And I fill in "Country" with "Colombia"
	And I fill in selection field "Categories" with "Afrika"
	And I fill in "Article type" with "Titelgeschichte"
	And I fill in Published date with "12 March 2010"
	And I fill in "Published in" with "Die Zeit"
	And I fill in "Author" with "Alexander Bühler"
	And I fill in "Photos by" with ""
	And I click on "Create Artikel"
	Then 1 article should exist
	And I should see "Artikel was successfully created"

# Dashboard
	When I am on on the Dashboard
	And I click on the link "Neuer Artikel"
	Then I should see "Article Details"
	And I should see "Neuer Artikel"

# Display article (frontend)
	When I go to the "Stories page"
	And I should see "Neuer Artikel"
	And I should see "Die Zeit"

#	Articles page (backend)
	When I go to the "Articles page"
	Then I should see "Id"
	And I should see "Title"
	And I should see "Short Title"
	And I should see "Categories"
	And I should see "Published Date"
	And I should see "Copyr."
	And I should see "Lang."
	And I should see "Teaser Image EN"
	And I should see "Switch To German"
	And I should see "Switch To English"

# Switch to German
	When I click on "Switch To German"
	Then I should see "Teaser Image"
	And I should not see "Teaser Image EN"
	When I click on "Switch To English"
	When I click on "Edit"

# Edit article
	Then I should see "Edit Article"
	And I should see "Switch To German"
	And I should see "Switch To English"

Scenario: Show error message when there are no articles in the database
	When I go to the "Stories page"
	Then I should see "Keine Stories gefunden"

Scenario: Show error message when the category passed in the url does not exist
	Given these article records exist
	| title   | short_title | url_title | categories | published_date | address | language |  
	| Artikel | Art.        | artikel   | Afrika     | 20100101       | Togo    | de       |  
	When I enter the path "/de/stories/strange" in the browser 
	Then I should see "Kategorie 'strange' wurde nicht gefunden"

Scenario: Show article with 'long' short title
	Given these article records exist
	| title   | short_title              | url_title | categories | published_date | address | language |  
	| Artikel | Art. long long long long | artikel   | Afrika     | 20100101       | Togo    | de       |  
	When I go to the "Stories page"
	Then I should see "Art. long long long long"

Scenario: Click on a story category should display the article
	Given these article records exist
	| title   | short_title              | url_title | categories | published_date | address | language |  
	| Artikel | Art. | artikel   | Afrika     | 20100101       | Togo    | de       |  
	When I go to the "Stories page"
	And I click on "Afrika"
	Then I should see "Artikel"
	And I should see "Art."
	And I should see "Afrika"

Scenario: Create Corporate Article
	Given no article exists
	And I am on the articles page
	When I click on "New Article"
	And I fill in "Title" with "Neuer Corporate Artikel"
	And I fill in "Short title" with "Corp. Artikel Long Long Long"
	And I fill in "Url title" with "neuer-corporate-artikel"
	And I fill in selection field "Categories" with "Corporate"
	And I fill in "Language" with "de"
	And I fill in "Country" with "Colombia"
	And I fill in "Article type" with "..."
	And I fill in Published date with "12 March 2010"
	And I fill in "Published in" with "Die Zeit"
	And I fill in "Author" with "Alexander Bühler"
	And I fill in "Photos by" with ""
	And I fill in "Viewer url" with "..."
	And I fill in "Embed code" with "..."
	And I click on "Create Artikel"
	Then 1 article should exist
	And I should see "Artikel was successfully created"
	And 1 article_ids_category_ids records should exist
	When I go to the "Corporate page"
	And I should see "Neuer Corporate Artikel"
	And I should see "Die Zeit"

Scenario: Show error message when there are no corporate articles in the database
	When I go to the "Corporate page"
	Then I should see "Kein Corporate Artikel gefunden"

Scenario: Show error message when the corporate article passed in the url does not exist
	Given these article records exist
	| title   | short_title | url_title | categories | published_date | address | language |  
	| Artikel | Art.        | artikel   | Corporate  | 20100101       | Togo    | de       |  
	When I enter the path "/de/corporate/strange" in the browser 
	Then I should see "Corporate Artikel 'strange' wurde nicht gefunden"

Scenario: Show corporate article with 'long' short title
	Given these article records exist
	| title   | short_title              | url_title | categories | published_date | address | language |  
	| Artikel | Art. long long long long | artikel   | Corporate  | 20100101       | Togo    | de       |  
	When I go to the "Corporate page"
	Then I should see "Art. long long long long"
