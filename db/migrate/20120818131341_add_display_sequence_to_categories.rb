class AddDisplaySequenceToCategories < ActiveRecord::Migration
  def change
  	add_column :categories, :display_sequence, :integer
  	add_column :categories, :display_section, :integer
  end
end
