class Subscriber < ApplicationRecord
  # Почту храним в одном виде, чтобы «Ivan@Mail.ru» и «ivan@mail.ru» не считались разными
  normalizes :email, with: ->(email) { email.strip.downcase }

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  # Галочка «Соглашаюсь на обработку персональных данных»; без неё подписка не сохраняется
  validates :consent, acceptance: { allow_nil: false }
end
