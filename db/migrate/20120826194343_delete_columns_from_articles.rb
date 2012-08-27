class DeleteColumnsFromArticles < ActiveRecord::Migration
  def up
  	remove_column :articles, :country
  	remove_column :articles, :related_country
  	remove_column :articles, :filename
  end

  def down
  	add_column :articles, :country, :string
  	add_column :articles, :related_country, :string
  	add_column :articles, :filename, :string
end
end
