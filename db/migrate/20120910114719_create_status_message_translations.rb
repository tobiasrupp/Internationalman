class CreateStatusMessageTranslations < ActiveRecord::Migration
  def up
    StatusMessage.create_translation_table!({
      text: :string,
      language: :string
    }, {
      migrate_data: true
    })
  end

  def down
    StatusMessage.drop_translation_table! migrate_data: true
  end
end
