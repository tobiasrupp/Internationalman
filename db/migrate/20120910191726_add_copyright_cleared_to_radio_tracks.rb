class AddCopyrightClearedToRadioTracks < ActiveRecord::Migration
  def change
    add_column :radio_tracks, :copyright_cleared, :boolean
  end
end
