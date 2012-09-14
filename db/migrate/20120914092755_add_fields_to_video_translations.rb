class AddFieldsToVideoTranslations < ActiveRecord::Migration
 	class Video < ActiveRecord::Base
  end

  def self.up
    add_column :video_translations, :embed_code, :text
    add_column :video_translations, :web_page, :string
    add_column :video_translations, :source_url, :string
  
		# migrate existing video data to translation table
		say "Copying any existing data to translation table."
		Video.reset_column_information
		I18n.locale = :de
		Video.all.each do |video|
			if !video.embed_code.blank?
		  execute "UPDATE video_translations SET embed_code='#{video.embed_code}' WHERE VIDEO_ID='#{video.id}'"
			end
			if !video.web_page.blank?
		  execute "UPDATE video_translations SET web_page='#{video.web_page}' WHERE VIDEO_ID='#{video.id}'"
			end
			if !video.source_url.blank?
		  execute "UPDATE video_translations SET source_url='#{video.source_url}' WHERE VIDEO_ID='#{video.id}'"
			end
		end
  end

  def self.down
  	remove_column :video_translations, :embed_code, :text
    remove_column :video_translations, :web_page, :string
    remove_column :video_translations, :source_url, :string
  end
end
