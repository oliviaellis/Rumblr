class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :image
      t.text :content
      t.integer :user_id
      t.datetime :created_at
    end
  end
end
