class AddWebPageToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :web_page, :string
  end
end
