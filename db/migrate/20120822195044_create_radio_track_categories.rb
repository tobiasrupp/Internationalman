class CreateRadioTrackCategories < ActiveRecord::Migration
  def change
    create_table :radio_track_categories do |t|
      t.integer :radio_track_id
      t.integer :category_id

      t.timestamps
    end
    add_index :radio_track_categories, :radio_track_id,   :unique => false
    add_index :radio_track_categories, :category_id,   		:unique => false
  end
end
