class AddCopyrightClearedToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :copyright_cleared, :boolean
  end
end
