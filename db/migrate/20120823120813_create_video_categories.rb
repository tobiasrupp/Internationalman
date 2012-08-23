class CreateVideoCategories < ActiveRecord::Migration
  def change
    create_table :video_categories do |t|
      t.integer :video_id
      t.integer :category_id
    end
    add_index :video_categories, :video_id,   			:unique => false
    add_index :video_categories, :category_id,   		:unique => false
  end
end
