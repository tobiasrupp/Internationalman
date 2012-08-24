class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :short_title
      t.string :url_title
      t.string :language
      t.string :author
      t.text :text
      t.string :country
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
