class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.references :rubric, null: false, foreign_key: true
      # Категория необязательна: не у каждого поста есть тип продукта
      t.references :category, foreign_key: true
      t.string :title, null: false
      t.string :slug, null: false
      t.text :lead
      t.string :cover
      # Текст поста в Markdown
      t.text :body
      t.string :status, null: false, default: "draft"
      t.datetime :published_at

      t.timestamps
    end
    add_index :posts, :slug, unique: true
    add_index :posts, [ :status, :published_at ]
  end
end
