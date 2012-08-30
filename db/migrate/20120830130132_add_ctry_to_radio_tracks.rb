class AddCtryToRadioTracks < ActiveRecord::Migration
  def change
    add_column :radio_tracks, :ctry, :string
  end
end
