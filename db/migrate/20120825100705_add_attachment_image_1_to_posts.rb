class AddAttachmentImage1ToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.has_attached_file :image_1
    end
  end

  def self.down
    drop_attached_file :posts, :image_1
  end
end
