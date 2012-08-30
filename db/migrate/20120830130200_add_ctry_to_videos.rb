class AddCtryToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :ctry, :string
  end
end
