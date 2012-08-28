class AddCtryAndWebPageToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :ctry, :string
    add_column :articles, :web_page, :string
  end
end
