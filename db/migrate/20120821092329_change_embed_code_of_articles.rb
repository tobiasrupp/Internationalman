class ChangeEmbedCodeOfArticles < ActiveRecord::Migration
  def up
  	change_table :articles do |t|	 
		  t.change :embed_code, :text
		end
  end

  def down
  	change_table :articles do |t|	 
		  t.change :embed_code, :string
		end
  end
end
