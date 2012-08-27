class CreateArticleTranslations < ActiveRecord::Migration
  def up
    Article.create_translation_table!({
      title: :string,
      short_title: :string,
      url_title: :string,
      article_type: :string,
      country: :string,
      language: :string 
    }, {
      migrate_data: true
    })
  end

  def down
    Article.drop_translation_table! migrate_data: true
  end
end
