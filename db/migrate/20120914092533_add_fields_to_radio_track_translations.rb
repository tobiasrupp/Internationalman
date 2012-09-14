class AddFieldsToRadioTrackTranslations < ActiveRecord::Migration
  class RadioTrack < ActiveRecord::Base
  end

  def self.up
    add_column :radio_track_translations, :web_page, :string
    add_column :radio_track_translations, :source_url, :string

    # migrate existing radio track data to translation table
		say "Copying any existing data to translation table."
		RadioTrack.reset_column_information
		I18n.locale = :de
		RadioTrack.all.each do |radio_track|
			if !radio_track.web_page.blank?
		  execute "UPDATE radio_track_translations SET web_page='#{radio_track.web_page}' WHERE radio_track_ID='#{radio_track.id}'"
			end
			if !radio_track.source_url.blank?
		  execute "UPDATE radio_track_translations SET source_url='#{radio_track.source_url}' WHERE radio_track_ID='#{radio_track.id}'"
			end
		end
  end

  def self.down
  	remove_column :radio_track_translations, :web_page, :string
    remove_column :radio_track_translations, :source_url, :string
  end
end
