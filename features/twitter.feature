Feature: Twitter Integration
	In order to read the client's Twitter status messages on the website
	As a user
	I want the application to pull Twitter updates and display them instead of normal status messages if they have been posted more recently

Scenario: Most recent message is a normal status message and there is no cached tweet in the table
	Given these status message records exist
	
		| text              | tweet_id | tweet_screen_name | tweet_created_at | language | created_at |  
		| Neueste Nachricht |          |                   |                  | de       | 20121010   |  
	
	When I go to the "Homepage"
	And I should see "Neueste Nachricht"

Scenario: Most recent message is a normal status message and there is an older cached tweet
	Given these status message records exist
	
		| text              | tweet_id  | tweet_screen_name | tweet_created_at | language | created_at |  
		| Neuester Tweet    | 258581398 | TobiasRupp        | 20111010         | de       | 20111010   | 
		| Neueste Nachricht |           |                   |                  | de       | 20121010   |  

	When I go to the "Homepage"
	And I should see "Neueste Nachricht"

Scenario: Most recent message is a tweet 
	Given these status message records exist
	
		| text              | tweet_id  | tweet_screen_name | tweet_created_at | language | created_at |  
		| Neueste Nachricht |           |                   |                  | de       | 20111010   |  
		| Neuester Tweet    | 258581398 | TobiasRupp        | 20121010         | de       | 20121010   |  

	When I go to the "Homepage"
	And I should see "Neuester Tweet"

# Scenario: There messages in the table but a more recent tweet exists on Twitter
# 	Given these status message records exist
	
# 		| text              | tweet_id  | tweet_screen_name | tweet_created_at | language | created_at |  
# 		| Neuester Tweet    | 258581398 | TobiasRupp        | 20111010         | de       | 20111010   | 
# 		| Neueste Nachricht |           |                   |                  | de       | 20121010   |  

# 	When I go to the "Homepage"
# 	And a test tweet exists created at "20101010"
# 	Then I should see "Test text created at"