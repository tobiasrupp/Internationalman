class AddAttachmentTeaserImageEnToVideos < ActiveRecord::Migration
  def self.up
    change_table :videos do |t|
      t.has_attached_file :teaser_image_en
    end
  end

  def self.down
    drop_attached_file :videos, :teaser_image_en
  end
end
