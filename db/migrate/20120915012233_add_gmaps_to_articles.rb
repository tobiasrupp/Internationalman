class AddGmapsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :gmaps, :boolean
  end
end
