class AddLatLonToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :lat, :float
    add_column :articles, :lon, :float
  end
end
