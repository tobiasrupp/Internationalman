Feature: Sidebar Navigation
	In order to find the content I am interested in
	As a user
	I use the sidebar navigation to browse Stories, Radio, TV and Corporate items


# Background:
# 	Given the following categories records
# 		|name|display_sequence|display_section|url_name|
# 		|Afrika|2|1|afrika|
# 		|Asien|1|1|asien|
# 		|Lateinamerika|3|1|lateinamerika|
# 		|Waffenhandel|1|2|waffenhandel|
# 		|Corporate|||corporate|
# 	And the following articles records
# 		|title|language|author|published_date|published_in|photos_by|
# 		|Artikel1|Deutsch|Alex|20000101|Testo|T. Rupp|
# 		|Artikel2|Deutsch|Alex|20010101|Financial Times|Eiko Weishaupt|
# 		|Artikel3|Deutsch|Alex|20020101|ZDF|T. Rupp|
# 		|Artikel4|Deutsch|Alex|20030101|ARD|T. Rupp|
# 		|Artikel5|Deutsch|Alex|20040101|Eine Zeitung||
# 		|Artikel6|Deutsch|Alex|20050101|Der Spiegel|Eiko Weishaupt|
# 		|Artikel7|Deutsch|Alex|20060101|Die Zeit|Eiko Weishaupt|
# 		|Artikel8|Deutsch|Alex|20070101|BASF|Eiko Weishaupt|
# 		|Artikel9|Deutsch|Alex|20080101|Shell|Eiko Weishaupt|
# 	And the following article_ids_category_ids records
# 		|article_title|category_name|
# 		|Artikel1|Afrika|
# 		|Artikel2|Afrika|
# 		|Artikel3|Asien|
# 		|Artikel4|Asien|
# 		|Artikel5|Lateinamerika|
# 		|Artikel6|Waffenhandel|
# 		|Artikel7|Lateinamerika|
# 		|Artikel8|Corporate|
# 		|Artikel9|Corporate|
# 	Then 5 categories should exist
# 	And 9 articles should exist
# 	And 9 article_ids_category_ids records should exist

# Scenario: Navigate to article
# 	When I go to the "Main page"
# 	Then I should see "Stories"
# 	And I should see "Afrika"
# 	And I should see "Asien"
# 	And I should see "Lateinamerika"
# 	And I should see "Waffenhandel"
# 	And I should see "Artikel7"
# 	And I should see "Artikel5"
# 	And I should see "Autor: Alex"
# 	And I should see "Titel: Artikel7"
# 	And I should see "Erschienen in: Die Zeit"
# 	And I should see "Erscheinungsdatum: January 01, 2006"
# 	And I should see "Fotos: Eiko Weishaupt"
	