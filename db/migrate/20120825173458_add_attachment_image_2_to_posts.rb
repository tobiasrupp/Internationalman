class AddAttachmentImage2ToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.has_attached_file :image_2
      add_column :posts, :image_2_options, :string
    end
  end

  def self.down
    drop_attached_file :posts, :image_2
    delete_column :posts, :image_2_options, :string
  end
end
