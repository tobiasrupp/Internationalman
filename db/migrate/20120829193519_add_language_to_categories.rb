class AddLanguageToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :language, :string
  end
end
