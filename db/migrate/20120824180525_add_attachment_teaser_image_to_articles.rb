class AddAttachmentTeaserImageToArticles < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.has_attached_file :teaser_image
    end
  end

  def self.down
    drop_attached_file :articles, :teaser_image
  end
end
