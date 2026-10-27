class CreateSubscribers < ActiveRecord::Migration[8.1]
  def change
    # Подписка на рассылку с заглушки и из футера. Сохраняем только после согласия
    # на обработку персональных данных, поэтому created_at — это и время согласия
    create_table :subscribers do |t|
      t.string :email, null: false

      t.timestamps
    end
    add_index :subscribers, :email, unique: true
  end
end
