Feature: Manage Blog
	In order to display blog posts on the website in the Blog section
	As a site admin or a user
	I want to create, show, edit and delete posts or find and read posts

Background:
	Given an admin user exists with email: "admin@example.com" and password: "password"
	And I log in with this user
	And the following categories records
	|name|display_sequence|display_section|url_name|language|
		|Afrika|2|1|afrika|de|
		|Corporate|||corporate|de|

Scenario: Create Post
	Given no "Post" exists
	And I go to the "Posts page"
	When I click on "New Post"
	And I fill in "Title" with "Neuer Testo Blogeintrag"
	And I fill in "Short title" with "N. Blogeintrag"
	And I fill in "Url title" with "neuer-testo-blogeintrag"
	And I fill in selection field "Categories" with "Afrika"
	And I fill in "Language" with "de"
	And I fill in "Country" with "Uganda"
	And I fill in "Longitude" with "long"
	And I fill in "Latitude" with "lat"
	And I choose radio button "Publication state" with "Published"
	And I fill in "Author" with "Alexander Bühler"
	And I fill in "Text" with "Dies ist ein Blog Text"
	And I click on "Create Post"
	Then 1 "Post" should exist
	And I should see "Post was successfully created"
	And 1 "PostCategory" should exist
	When I go to the "Blog page"
	And I should see "Neuer Testo Blogeintrag"
	And I should see "Dies ist ein Blog Text"
	And I should see "Afrika"
	And I should see "Dies ist ein Blog Text"