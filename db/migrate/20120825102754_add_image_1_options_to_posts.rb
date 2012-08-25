class AddImage1OptionsToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :image_1_options, :string
  end
end
