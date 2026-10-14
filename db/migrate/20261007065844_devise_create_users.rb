# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      ## Вход по email и паролю (Devise хранит только хеш)
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Блокировка после неверных паролей (модуль lockable)
      t.integer  :failed_attempts, default: 0, null: false
      t.datetime :locked_at

      ## Роль: "user" или "admin"
      t.string :role, default: "user", null: false

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end