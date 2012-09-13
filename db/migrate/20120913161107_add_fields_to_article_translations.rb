class AddFieldsToArticleTranslations < ActiveRecord::Migration
  def change
    add_column :article_translations, :web_page, :string
    add_column :article_translations, :viewer_url, :string
    add_column :article_translations, :embed_code, :text
  end
end
