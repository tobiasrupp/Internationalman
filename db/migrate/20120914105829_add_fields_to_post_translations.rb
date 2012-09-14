class AddFieldsToPostTranslations < ActiveRecord::Migration
  
  class Post < ActiveRecord::Base
  end

  def self.up
    add_column :post_translations, :text, :text
    add_column :post_translations, :text_2, :text

    # migrate existing post data to translation table
		say "Copying any existing data to translation table."
		Post.reset_column_information
		I18n.locale = :de
		Post.all.each do |post|
			if !post.text.blank?
		  execute "UPDATE post_translations SET text=\"#{post.text.html_safe}\" WHERE post_ID='#{post.id}'"
			end
			if !post.text_2.blank?
		  execute "UPDATE post_translations SET text_2=\"#{post.text_2.html_safe}\" WHERE post_ID='#{post.id}'"
			end
		end
  end

  def self.down
  	remove_column :post_translations, :text, :text
    remove_column :post_translations, :text_2, :text
  end
end
