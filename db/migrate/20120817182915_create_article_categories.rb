class CreateArticleCategories < ActiveRecord::Migration
   def up
    create_table :article_categories, :id => false do |t|
      t.integer :article_id
      t.integer :category_id
    end
    add_index :article_categories, :article_id,    :unique => false
    add_index :article_categories, :category_id,   :unique => false
  end

  def down
  	drop_table :article_categories
  end
end
