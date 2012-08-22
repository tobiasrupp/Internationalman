class DeleteTimestampFromRadioTrackCategories < ActiveRecord::Migration
  def up
		remove_column :radio_track_categories, :created_at
		remove_column :radio_track_categories, :updated_at
  end

  def down
		add_column :radio_track_categories, :created_at, :datetime
		add_column :radio_track_categories, :updated_at, :datetime
  end
end
