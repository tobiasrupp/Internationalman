class AddFieldsToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :short_title, :string
  	add_column :articles, :viewer_url, :string
  end
end
