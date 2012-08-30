class AddCtryToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :ctry, :string
  end
end
