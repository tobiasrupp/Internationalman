class AddWebPageToRadioTracks < ActiveRecord::Migration
  def change
  	add_column :radio_tracks, :web_page, :string
  end
end
