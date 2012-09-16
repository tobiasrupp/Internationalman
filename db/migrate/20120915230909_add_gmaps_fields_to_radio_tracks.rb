class AddGmapsFieldsToRadioTracks < ActiveRecord::Migration
  def change
    add_column :radio_tracks, :lat, :float
    add_column :radio_tracks, :lon, :float
    add_column :radio_tracks, :gmaps, :boolean
    add_column :radio_tracks, :address, :string
  end
end
