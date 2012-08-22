class CreateRadioTracks < ActiveRecord::Migration
  def change
    create_table :radio_tracks do |t|
      t.string :title
      t.string :short_title
      t.string :url_title
      t.string :language
      t.string :country
      t.string :longitude
      t.string :latitude
      t.integer :duration
      t.date :broadcast_date
      t.string :broadcaster
      t.string :filename
      t.string :author
      t.string :source_url

      t.timestamps
    end
  end
end
