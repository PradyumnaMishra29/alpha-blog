class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    #for change in this table structure just create another migration file 
    create_table :articles do |t|
      t.string :title
      t.text :description
    end
  end
end
