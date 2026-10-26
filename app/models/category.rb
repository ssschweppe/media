class Category < ApplicationRecord
  # Категорию с постами удалить нельзя, как и рубрику
  has_many :posts, dependent: :restrict_with_error

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true, format: { with: SLUG_FORMAT, message: :slug_format }
  validates :position, numericality: { only_integer: true }

  scope :ordered, -> { order(:position, :name) }
end
