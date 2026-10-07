class CreateCardItems < ActiveRecord::Migration[8.1]
  def change
    create_table :card_items do |t|
      t.integer :kind
      t.text :text
      t.integer :position
      t.references :breakdown, null: false, foreign_key: true
      t.references :source, null: true, foreign_key: true

      t.timestamps
    end
  end
end
