class CreateStatusMessages < ActiveRecord::Migration
  def change
    create_table :status_messages do |t|
      t.string :text
      t.string :language
      t.timestamps
    end
  end
end
