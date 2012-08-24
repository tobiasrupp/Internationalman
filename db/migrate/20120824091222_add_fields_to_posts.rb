class AddFieldsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :publication_state, :string
    add_column :posts, :allow_comments, :boolean
  end
end
