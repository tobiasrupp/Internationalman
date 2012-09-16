class AddGmapsFieldsToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :lat, :float
    add_column :videos, :lon, :float
    add_column :videos, :gmaps, :boolean
    add_column :videos, :address, :string
  end
end
