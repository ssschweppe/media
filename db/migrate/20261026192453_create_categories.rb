class CreateCategories < ActiveRecord::Migration[8.1]
  def change
    # Тип продукта: сайт организации, интернет-магазин, мобильное приложение и т. д.
    create_table :categories do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.text :description
      t.integer :position, null: false, default: 0

      t.timestamps
    end
    add_index :categories, :slug, unique: true
  end
end
