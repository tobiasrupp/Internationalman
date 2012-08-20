class AddUrlNameToCategories < ActiveRecord::Migration
  def change
  	add_column :categories, :url_name, :string
  end
end
