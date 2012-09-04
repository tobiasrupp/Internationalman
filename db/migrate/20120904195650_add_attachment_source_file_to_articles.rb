class AddAttachmentSourceFileToArticles < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.has_attached_file :source_file
    end
  end

  def self.down
    drop_attached_file :articles, :source_file
  end
end
