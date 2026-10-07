class CreateSources < ActiveRecord::Migration[8.1]
  def change
    create_table :sources do |t|
      t.string :title
      t.string :url
      t.integer :kind

      t.timestamps
    end
  end
end
