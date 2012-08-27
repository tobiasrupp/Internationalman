class AddRelatedCountryToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :related_country, :string
  end
end
