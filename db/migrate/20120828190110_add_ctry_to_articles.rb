class AddCtryToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :ctry, :string
  end
end
