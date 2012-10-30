Feature: Manage Categories
	In order to maintain categories for different output types 
	As an admin
	I want to be able to create, show, edit and delete categories in the backend

Background:
	Given an admin user exists with email: "admin@example.com" and password: "password"
	And I log in with this user

Scenario: Create Category
	Given no "Category" exists
	And I go to the "Categories page"
	When I click on "New Category"
	And I fill in "Name" with "Neue Test Kategorie"
	And I fill in "Url name" with "neue-test-kategorie"
	And I fill in "Language" with "de"
	And I fill in "Display sequence" with "1"
	And I fill in "Display section" with "1"
	And I click on "Create Kategorie"
	Then 1 "Category" should exist
	And I should see "Kategorie was successfully created"
	And 1 "Category" should exist

#	Categories page (backend)
	When I go to the "Categories page"
	Then I should see "Id"
	And I should see "Name"
	And I should see "Url Name"
	And I should see "Display Sequence"
	And I should see "Display Section"
	And I should see "Lang."
	And I should see "Switch To German"
	And I should see "Switch To English"
	When I click on "Edit"

# Edit page
	Then I should see "Edit Category"
	And I should see "Switch To German"
	And I should see "Switch To English"