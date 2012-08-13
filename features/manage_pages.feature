Feature: Manage Pages
	In order to get information about the journalist Alexander Bühler 
	As a user
	I want to be able to view his website

Scenario: Show Homepage
	When I go to www.internationalman.de
	Then I shoud see "Alexander Bühler"
	And I shoud see "Journalist"
	And I shoud see a link "Deutsch"
	And I shoud see a link "English"
	And i should see the page title "International Man | Home"