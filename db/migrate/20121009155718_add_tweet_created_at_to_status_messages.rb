class AddTweetCreatedAtToStatusMessages < ActiveRecord::Migration
  def change
    add_column :status_messages, :tweet_created_at, :datetime
  end
end
