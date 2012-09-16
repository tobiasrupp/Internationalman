class AddGmapsFieldsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :lat, :float
    add_column :posts, :lon, :float
    add_column :posts, :gmaps, :boolean
    add_column :posts, :address, :string
  end
end
