class CreatePatterns < ActiveRecord::Migration[8.1]
  def change
    create_table :patterns do |t|
      t.string :title
      t.text :summary
      t.text :body
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
