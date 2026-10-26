class CreateRubrics < ActiveRecord::Migration[8.1]
  def change
    # Редакционные разделы: «Что бы мы выкинули», «Кейсы», «Госзаказ под лупой»
    create_table :rubrics do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.text :description
      t.integer :position, null: false, default: 0

      t.timestamps
    end
    add_index :rubrics, :slug, unique: true
  end
end
