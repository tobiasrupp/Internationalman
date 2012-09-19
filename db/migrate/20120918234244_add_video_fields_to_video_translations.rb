class AddVideoFieldsToVideoTranslations < ActiveRecord::Migration
  def change
    add_column :video_translations, :video_width, :string
    add_column :video_translations, :video_height, :string
    add_column :video_translations, :video_aspect_ratio, :string
  end
end
