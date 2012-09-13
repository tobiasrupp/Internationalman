class AddAttachmentTeaserImageEnSourceFileEnToArticles < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.has_attached_file :teaser_image_en
      t.has_attached_file :source_file_en
    end
  end

  def self.down
    drop_attached_file :articles, :teaser_image_en
    drop_attached_file :articles, :source_file_en
  end
end
