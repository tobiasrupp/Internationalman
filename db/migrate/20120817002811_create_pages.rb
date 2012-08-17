class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :page_type
      t.text :body

      t.timestamps
    end
  end
end
