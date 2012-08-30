class CreatePageTranslations < ActiveRecord::Migration
  def up
    Page.create_translation_table!({
      title: :string,
      body: :text,
      language: :string
    }, {
      migrate_data: true
    })
  end

  def down
    Page.drop_translation_table! migrate_data: true
  end
end
