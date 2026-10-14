class User < ApplicationRecord
  # database_authenticatable: вход по паролю
  # registerable: регистрация читателей
  # lockable: пауза после неверных паролей
  # validatable: проверка формата email и длины пароля
  devise :database_authenticatable, :registerable, :lockable, :validatable

  ROLES = %w[user admin].freeze

  validates :role, inclusion: { in: ROLES }

  def admin?
    role == "admin"
  end
end