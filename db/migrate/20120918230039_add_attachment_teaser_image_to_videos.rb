class AddAttachmentTeaserImageToVideos < ActiveRecord::Migration
  def self.up
    change_table :videos do |t|
      t.has_attached_file :teaser_image
    end
  end

  def self.down
    drop_attached_file :videos, :teaser_image
  end
end
