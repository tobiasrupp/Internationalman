class AddCameraByToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :camera_by, :string
  end
end
