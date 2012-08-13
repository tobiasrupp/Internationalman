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
	And i should see the page title "International Man | Startseite"

Scenario: Show Main Page in German
	Given I am on the Homepage
	When I click on "Deutsch"
	Then i should see the page title "International Man | Menü"
	And I shoud see "Alexander Bühler"
	And I shoud see "Journalist"
	And I shoud see "Stories"
	And I shoud see "Blog"
	And I shoud see "Corporate"
	And I shoud see "TV"
	And I shoud see "Radio"
	And I shoud see "Über mich"
	And I shoud see "Kontakt"
	
Scenario: Show About Me Page
	Given I am on the Main Page
	When I click on "Über mich"
	Then i should see the page title "International Man | Über mich"
	And I shoud see "Alexander Bühler"
	And I shoud see "Journalist"

Scenario: Show Contact Page
	Given I am on the Main Page
	When I click on "Kontakt"
	Then i should see the page title "International Man | Kontakt"
	And I shoud see "Alexander Bühler"
	And I shoud see "Journalist"
	And I shoud see "Email"
	And I shoud see "Tel"
