class AddVideoFieldsToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :video_width, :string
    add_column :videos, :video_height, :string
    add_column :videos, :video_aspect_ratio, :string
  end
end
