Feature: Sidebar Navigation
	In order to find the content I am interested in
	As a user
	I use the sidebar navigation to browse Stories, Radio, TV and Corporate items


Background:
	Given the following categories records
		|name|
		|Afrika|
		|Asien|
		|Lateinamerika|
		|Waffenhandel|
		|Corporate|
	And the following articles records
		|title|language|author|published_date|
		|Artikel1|Deutsch|Alex|20000101|
		|Artikel2|Deutsch|Alex|20010101|
		|Artikel3|Deutsch|Alex|20020101|
		|Artikel4|Deutsch|Alex|20030101|
		|Artikel5|Deutsch|Alex|20040101|
		|Artikel6|Deutsch|Alex|20050101|
		|Artikel7|Deutsch|Alex|20060101|
		|Artikel8|Deutsch|Alex|20070101|
		|Artikel9|Deutsch|Alex|20080101|
	And the following article_ids_category_ids records
		|article_title|category_name|
		|Artikel1|Afrika|
		|Artikel2|Afrika|
		|Artikel3|Asien|
		|Artikel4|Asien|
		|Artikel5|Lateinamerika|
		|Artikel6|Waffenhandel|
		|Artikel7|Lateinamerika|
		|Artikel8|Corporate|
		|Artikel9|Corporate|
	Then 5 categories should exist
	And 9 articles should exist
	And 9 article_ids_category_ids records should exist

@focus
Scenario: Navigate to article
	When I go to the "Main page"
