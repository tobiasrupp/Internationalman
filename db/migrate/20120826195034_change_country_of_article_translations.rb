class ChangeCountryOfArticleTranslations < ActiveRecord::Migration
  def up
  	rename_column :article_translations, :country, :ctry
  end

  def down
  	rename_column :article_translations, :ctry, :country
  end
end
