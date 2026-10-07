class CreateBreakdowns < ActiveRecord::Migration[8.1]
  def change
    create_table :breakdowns do |t|
      t.string :title
      t.text :lead
      t.text :body
      t.string :demo_key
      t.datetime :published_at
      t.references :pattern, null: false, foreign_key: true
      t.references :example, null: false, foreign_key: true

      t.timestamps
    end
  end
end
