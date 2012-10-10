class AddTwitterFieldsToStatusMessages < ActiveRecord::Migration
  def change
    add_column :status_messages, :tweet_id, :string
    add_column :status_messages, :tweet_screen_name, :string
  end
end
