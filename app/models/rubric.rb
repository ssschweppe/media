class Rubric < ApplicationRecord
  # Рубрику с постами удалить нельзя: destroy вернёт false и добавит понятную ошибку
  has_many :posts, dependent: :restrict_with_error

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true, format: { with: SLUG_FORMAT, message: :slug_format }
  validates :position, numericality: { only_integer: true }

  scope :ordered, -> { order(:position, :name) }
end
