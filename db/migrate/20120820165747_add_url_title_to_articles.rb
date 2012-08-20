class AddUrlTitleToArticles < ActiveRecord::Migration
  def change
  		add_column :articles, :url_title, :string
  end
end
