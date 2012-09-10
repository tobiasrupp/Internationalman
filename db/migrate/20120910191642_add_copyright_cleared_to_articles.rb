class AddCopyrightClearedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :copyright_cleared, :boolean
  end
end
