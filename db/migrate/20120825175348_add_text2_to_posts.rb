class AddText2ToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :text_2, :text
  end
end
