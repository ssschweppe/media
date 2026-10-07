class CreateStudios < ActiveRecord::Migration[8.1]
  def change
    create_table :studios do |t|
      t.string :name
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end
