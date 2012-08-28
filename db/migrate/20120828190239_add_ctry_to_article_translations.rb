class AddCtryToArticleTranslations < ActiveRecord::Migration
  def change
    add_column :article_translations, :ctry, :string
  end
end
