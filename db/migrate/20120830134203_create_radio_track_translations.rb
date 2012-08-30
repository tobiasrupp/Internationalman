class CreateRadioTrackTranslations < ActiveRecord::Migration
  def up
    RadioTrack.create_translation_table!({
      title: :string,
      short_title: :string,
      url_title: :string,
      ctry: :string,
      language: :string
    }, {
      migrate_data: true
    })
  end

  def down
    RadioTrack.drop_translation_table! migrate_data: true
  end
end
