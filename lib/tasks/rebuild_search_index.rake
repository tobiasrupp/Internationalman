desc "Delete and rebuild Search Index"
task :rebuild_search_index => :environment do

	PgSearch::Document.delete_all(:searchable_type => "Article")
	puts "Article search index deleted..."
	PgSearch::Document.delete_all(:searchable_type => "Video")
	puts "Video search index deleted..."
	PgSearch::Document.delete_all(:searchable_type => "RadioTrack")
	puts "Radio Track search index deleted..."
	PgSearch::Document.delete_all(:searchable_type => "Post")
	puts "Post search index deleted..."
	Article.find_each { |record| record.update_pg_search_document }
	puts "Article search index rebuilt..."
	Video.find_each { |record| record.update_pg_search_document }
	puts "Video search index rebuilt..."
	RadioTrack.find_each { |record| record.update_pg_search_document }
	puts "Radio Track search index rebuilt..."
	Post.find_each { |record| record.update_pg_search_document }
	puts "Post search index rebuilt..."
	puts "Search index has been rebuilt successfully."
end