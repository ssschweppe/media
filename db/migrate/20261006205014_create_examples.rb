class CreateExamples < ActiveRecord::Migration[8.1]
  def change
    create_table :examples do |t|
      t.string :name
      t.string :url
      t.text :description
      t.references :studio, null: true, foreign_key: true #null:true -- студия может быть не указана

      t.timestamps
    end
  end
end
