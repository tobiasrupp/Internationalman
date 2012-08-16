class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :language
      t.string :country
      t.string :longitude
      t.string :latitude
      t.string :article_type
      t.date :published_date
      t.string :published_in
      t.string :filename
      t.string :author
      t.string :photos_by

      t.timestamps
    end
  end
end
